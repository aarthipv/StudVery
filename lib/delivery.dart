import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/main.dart'; // Import MyHomePage
import 'theme_notifier.dart'; // Import the ThemeNotifier
import 'common_app_bar.dart'; // Import the CommonAppBar

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 1,
      'destination': 'Apex Block, AB507',
      'totalPrice': 200,
      'user': 'Riya',
      'phone': '1234567891',
      'status': 'Accept Request',
      'items': [
        {'name': 'Masala Dosa', 'quantity': 2, 'source': 'ESB Canteen'},
        {'name': 'Bluebooks', 'quantity': 3, 'source': 'MSRIT Stationary'},
      ],
    },
    {
      'orderId': 2,
      'destination': 'Architecture Block, Lecture Hall 1',
      'totalPrice': 150,
      'user': 'Dhruv',
      'phone': '1234567892',
      'status': 'Accept Request',
      'items': [
        {'name': 'Idli', 'quantity': 4, 'source': 'ESB Canteen'},
        {'name': 'Pens', 'quantity': 5, 'source': 'MSRIT Stationary'},
      ],
    },
    {
      'orderId': 3,
      'destination': 'LHC 203',
      'totalPrice': 300,
      'user': 'Aditya',
      'phone': '1234567893',
      'status': 'Accept Request',
      'items': [
        {'name': 'Vada', 'quantity': 6, 'source': 'ESB Canteen'},
        {'name': 'Notebooks', 'quantity': 2, 'source': 'MSRIT Stationary'},
      ],
    },
    {
      'orderId': 4,
      'destination': 'DES CSE Lab 2',
      'totalPrice': 250,
      'user': 'Dinesh',
      'phone': '1234567894',
      'status': 'Accept Request',
      'items': [
        {'name': 'Samosa', 'quantity': 3, 'source': 'ESB Canteen'},
        {'name': 'Markers', 'quantity': 4, 'source': 'MSRIT Stationary'},
      ],
    },
  ];

  void updateStatus(int index) {
    setState(() {
      if (orders[index]['status'] == 'Accept Request') {
        orders[index]['status'] = 'Ongoing';
      } else if (orders[index]['status'] == 'Ongoing') {
        orders[index]['status'] = 'Completed';
      }
    });
  }

  String getStatus(int index) {
    return orders[index]['status'];
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Ongoing':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(isOrdererMode: false),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${order['orderId']}'),
                  Text('Destination: ${order['destination']}'),
                  Text('Total Price: ₹${order['totalPrice']}'),
                  Text('User: ${order['user']}'),
                  Text('Phone: ${order['phone']}'),
                  Row(
                    children: [
                      Text('Status: '),
                      Text(
                        getStatus(index),
                        style: TextStyle(
                          color: getStatusColor(getStatus(index)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Items:'),
                  ...order['items'].map<Widget>((item) {
                    return Text(
                        '${item['quantity']} x ${item['name']} from ${item['source']}');
                  }).toList(),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      updateStatus(index);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getStatusColor(getStatus(index)),
                    ),
                    child: Text(getStatus(index)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}