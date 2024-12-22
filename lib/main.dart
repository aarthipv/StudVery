import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/Splash.dart';
import 'package:flutter_application_2/orderer.dart';
import 'theme_notifier.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'RazorpaymentPage.dart';
import 'delivery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'StudVery',
          theme: ThemeData.light().copyWith(
            primaryColor: Colors.purple
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.purple
          ),
          themeMode: themeNotifier.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOrdererMode = true;

  void toggleMode(bool isOrderer) {
    setState(() {
      isOrdererMode = isOrderer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOrdererMode ? OrdererPage() : DeliveryPage();
  }
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