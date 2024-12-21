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

class OrdererPage extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {'title': 'ESB Canteen', 'icon': Icons.fastfood, 'page': ESBCanteenPage()},
    {
      'title': 'Multipurpose Canteen',
      'icon': Icons.restaurant,
      'page': MultipurposeCanteenPage()
    },
    {
      'title': 'Law Canteen',
      'icon': Icons.lunch_dining,
      'page': LawCanteenPage()
    },
    {'title': 'Stationery', 'icon': Icons.edit_note, 'page': StationaryPage()},
    {'title': 'Xerox', 'icon': Icons.print, 'page': XeroxPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orderer Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DelivererPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(options[index]['icon']),
            title: Text(options[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => options[index]['page']),
              );
            },
          );
        },
      ),
    );
  }
}