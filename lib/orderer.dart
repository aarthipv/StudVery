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
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter_application_2/pickuppage.dart';
import 'package:flutter_application_2/orderproblem.dart';


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
      'tags': ['idli', 'vada', 'dosa', 'chapathi', 'esb', 'canteen']
    },
    {
      'title': 'Multipurpose Canteen',
      'icon': Icons.restaurant,
      'page': MultipurposeCanteenPage(),
      'tags': ['north mess', 'south mess', 'canteen', 'meals', 'multipurpose']
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
      'image': 'assets/masala_dosa.jpg',
      'tagline': 'Haven\'t tried the masala dosa? Click here!',
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
      'image': 'assets/photocopy.jpg',
      'tagline': 'Quick photocopy services available!',
      'page': XeroxPage(),
    },
    {
      'image': 'assets/moosambi_juice.jpg',
      'tagline': 'Feeling tired, try our moosambi juice!',
      'page': ESBCanteenPage(),
    },
  ];

  int _currentIndex = 0;
  final carousel_slider.CarouselController _controller = carousel_slider.CarouselController();

  @override
  Widget build(BuildContext context) {
    final filteredOptions = options
        .where((option) =>
            option['title'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        // title:
        //     Text('Order Mode', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.report_problem),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdererProblemsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              cursorColor: const Color.fromARGB(255, 0, 0, 0), // Cursor color
              decoration: InputDecoration(
                hintText: 'Search for items, canteens, shops...',
                prefixIcon: Icon(Icons.search, color: Colors.purple),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(
                        255, 19, 15, 19), // Border color when focused
                    width: 2.0, // Border width when focused
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.purple[300]!, // Border color when not focused
                    width: 2.0, // Border width when not focused
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  carousel_slider.CarouselSlider(
                    items: carouselItems.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => item['page'],
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(item['image']),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    color: Colors.black54,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Text(
                                      item['tagline'],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.purple, size: 30),
                      onPressed: () {
                        _controller.previousPage();
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          color: Colors.purple, size: 30),
                      onPressed: () {
                        _controller.nextPage();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredOptions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => filteredOptions[index]['page'],
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      color: Colors.purple[50],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              filteredOptions[index]['icon'],
                              size: 40,
                              color: Colors.purple,
                            ),
                            SizedBox(height: 10),
                            Text(
                              filteredOptions[index]['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[900],
                              ),
                              textAlign: TextAlign.center,
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
      ),
    );
  }
}