import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/RegistrationPage.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/Splash.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/canteens.dart';
import 'package:flutter_application_2/xerox.dart';
import 'package:flutter_application_2/delivery.dart';
import 'package:flutter_application_2/stationary.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_2/pickuppage.dart';

class PickupPage extends StatefulWidget {
  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  String selectedGate = '';
  List<Map<String, dynamic>> menuItems = [
    {'name': 'Pickup from Gate 1', 'price': 10},
    {'name': 'Pickup from Gate 2', 'price': 10},
    {'name': 'Pickup from Gate 3', 'price': 10},
    {'name': 'Pickup from Gate 8', 'price': 10},
    {'name': 'Pickup from Gate 10', 'price': 10},
    {'name': 'Pickup from Gate 11', 'price': 10},
  ];

  List<int?> quantities = List<int?>.filled(6, 0); // Adjust the size as needed

  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantities[index] = (quantities[index] ?? 0) + 1;

        // Add item to the cart
        final item = CartItem(
          name: menuItems[index]['name'],
          price: menuItems[index]['price'],
          quantity: 1,
        );
        cartState.addItem(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if ((quantities[index] ?? 0) > 0) {
          quantities[index] = (quantities[index] ?? 0) - 1;
        }
      }
    });
  }

  void addToCart(String gate) {
    // Add the selected gate to the cart with a service charge of 10 Rs
    final item = CartItem(
      name: 'Pickup from $gate',
      price: 10,
      quantity: 1,
    );
    cartState.addItem(item);

    // Navigate to CartPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup from Gate',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pickup from Gate',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select your preferred gate for pickup:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple[700],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(menuItems[index]['name']),
                      subtitle: Text('Price: ${menuItems[index]['price']} Rs'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => updateQuantity(index, false),
                          ),
                          Text('${quantities[index] ?? 0}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => updateQuantity(index, true),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple[700],
      ),
    );
  }
}