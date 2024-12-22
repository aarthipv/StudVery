import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/RegistrationPage.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/Splash.dart';
import 'package:flutter_application_2/orderer.dart';
import 'package:flutter_application_2/canteens.dart';
import 'package:flutter_application_2/xerox.dart';
import 'package:flutter_application_2/delivery.dart';
import 'package:flutter_application_2/stationary.dart';
import 'package:flutter_application_2/RazorpaymentPage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:html';
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use the Firebase options
  );
  runApp(MyApp());
}

final cartState = CartState();

class CartItem {
  final String name;
  final int price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}

class CartState {
  List<CartItem> items = [];
  int studCharge = 5;

  int get subtotal =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get total => subtotal + studCharge;

  void addItem(CartItem item) {
    final existingItem = items.firstWhere((i) => i.name == item.name,
        orElse: () => CartItem(name: '', price: 0));
    if (existingItem.name.isEmpty) {
      items.add(item);
    } else {
      existingItem.quantity += item.quantity;
    }
  }

  void removeItem(String name) {
    items.removeWhere((item) => item.name == name);
  }

  void clearCart() {
    items.clear();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudVery',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        onSplashComplete: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController classNumberController = TextEditingController();

  void openCheckout() {
    var options = js_util.jsify({
      'key': 'rzp_test_ry9cS8x8J3XYbD',
      'amount': cartState.total * 100,
      'name': 'StudVery',
      'description': 'Payment for your cart',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
      'theme': {'color': '#F37254'}
    });
    try {
      js.context.callMethod('openRazorpayPayment', [
        options,
        js.allowInterop((response) {
          // Handle success
          print('Payment successful: $response');
        }),
        js.allowInterop((response) {
          // Handle failure
          print('Payment failed: $response');
        })
      ]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: classNumberController,
              decoration: InputDecoration(
                labelText: 'Class Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: openCheckout,
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainAppPage extends StatefulWidget {
  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  bool isOrderer = false; // For Orderer/Stud toggle
  bool isDarkTheme = false; // For Light/Dark theme toggle

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple, // Purple AppBar for light theme
          foregroundColor: Colors.white, // White text and icons
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple, // Purple AppBar for dark theme
          foregroundColor: Colors.white, // White text and icons
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isOrderer ? 'Stud Mode' : 'Orderer Mode',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Switch(
                  value: isOrderer,
                  onChanged: (value) {
                    setState(() {
                      isOrderer = value;
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Color.fromARGB(255, 147, 38, 38),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                ),
              ],
            ),
          ),
          actions: [
            // Light/Dark Theme Toggle
            IconButton(
              icon: Icon(
                isDarkTheme ? Icons.nights_stay : Icons.wb_sunny,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isDarkTheme = !isDarkTheme;
                });
              },
            ),
          ],
        ),
        body: isOrderer ? DeliveryPage() : OrdererPage(),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classNumberController = TextEditingController();
  String selectedBlock = 'ESB';
  bool showDeliveryLocation = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDeliveryLocation() {
    setState(() {
      showDeliveryLocation = !showDeliveryLocation;
      if (showDeliveryLocation) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: cartState.items.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartState.items.length,
                    itemBuilder: (context, index) {
                      final item = cartState.items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('₹${item.price} x ${item.quantity}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            cartState.removeItem(item.name);
                            (context as Element).markNeedsBuild();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Subtotal'),
                  trailing: Text('₹${cartState.subtotal}'),
                ),
                ListTile(
                  title: Text('Stud Charge'),
                  trailing: Text('₹${cartState.studCharge}'),
                ),
                ListTile(
                  title: Text('Total'),
                  trailing: Text('₹${cartState.total}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _toggleDeliveryLocation,
                    child: Text('Confirm'),
                  ),
                ),
                SizeTransition(
                  sizeFactor: _animation,
                  axisAlignment: -1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedBlock,
                          decoration: InputDecoration(
                            labelText: 'Block Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: [
                            'ESB',
                            'DES',
                            'LHC',
                            'ARCHITECTURE',
                            'CRD',
                            'WWORKSHOP'
                          ]
                              .map((block) => DropdownMenuItem(
                                    child: Text(block),
                                    value: block,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedBlock = value!;
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: classNumberController,
                          decoration: InputDecoration(
                            labelText: 'Class Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RazorpayPaymentPage(
                                        cartState: cartState,
                                      )),
                            );
                          },
                          child: Text('Proceed to Payment'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// Separate pages for each entity