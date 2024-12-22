import 'package:flutter/material.dart';
import 'package:flutter_application_2/RegistrationPage.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/Splash.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/canteens.dart';
import 'package:flutter_application_2/xerox.dart';
import 'package:flutter_application_2/delivery.dart';
import 'package:flutter_application_2/stationary.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_2/pickuppage.dart';
import 'package:flutter_application_2/orderproblem.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:provider/provider.dart';
import 'main.dart'; // Import the CartState class
import 'theme_notifier.dart'; // Import the ThemeNotifier

class OrdererPage extends StatefulWidget {
  @override
  _OrdererPageState createState() => _OrdererPageState();
}

class _OrdererPageState extends State<OrdererPage> {
  final List<Map<String, dynamic>> options = [
    {
      'title': 'ESB Canteen',
      'icon': Icons.fastfood,
      'page': ESBCanteenPage(),
      'tags': ['esb', 'canteen', 'food', 'snacks']
    },
    {
      'title': 'Multipurpose Canteen',
      'icon': Icons.restaurant,
      'page': MultipurposeCanteenPage(),
      'tags': ['multipurpose', 'canteen', 'food', 'snacks']
    },
    {
      'title': 'Law Canteen',
      'icon': Icons.lunch_dining,
      'page': LawCanteenPage(),
      'tags': ['law', 'canteen', 'lunch', 'food']
    },
    {
      'title': 'Stationery',
      'icon': Icons.edit_note,
      'page': StationaryPage(),
      'tags': ['books', 'pens', 'stationery', 'notebooks', 'shop']
    },
    {
      'title': 'Xerox',
      'icon': Icons.print,
      'page': XeroxPage(),
      'tags': ['xerox', 'printing', 'documents', 'photocopy', 'shop']
    },
    {
      'title': 'Pickup from Gate',
      'icon': Icons.local_shipping,
      'page': PickupPage(),
      'tags': ['pickup', 'delivery', 'gate']
    },
  ];

  String searchQuery = '';

  final List<Map<String, dynamic>> carouselItems = [
    {
      'image': 'assets/moosambi_juice.jpg',
      'tagline': 'Feeling tired, try our moosambi juice!',
      'page': ESBCanteenPage(),
    },
    {
      'image': 'assets/pen.jpg',
      'tagline': 'Ran out of ink? Stud will deliver in 2 mins!',
      'page': StationaryPage(),
    },
    {
      'image': 'assets/notebook.jpg',
      'tagline': 'Need a new notebook? Get it now!',
      'page': StationaryPage(),
    },
    {
      'image': 'assets/photocopy.png',
      'tagline': 'Quick photocopy services available!',
      'page': XeroxPage(),
    },
  ];

  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final filteredOptions = options
        .where((option) =>
            option['title'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Text(
                'Orderer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text('|', style: TextStyle(color: Colors.grey)),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryPage()),
                );
              },
              child: Text(
                'Deliverer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeNotifier>(context).isDarkTheme
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: carouselItems.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item['page']),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Image.asset(item['image'], fit: BoxFit.cover),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            carouselController: _controller,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOptions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => filteredOptions[index]['page']),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    color: Colors.purple[50],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Icon(
                            filteredOptions[index]['icon'],
                            size: 40,
                            color: Colors.purple,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              filteredOptions[index]['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart, size: 30),
        backgroundColor: Colors.purple,
      ),
    );
  }
}