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
import 'package:flutter_application_2/orderproblem.dart';
import 'package:flutter_application_2/orderproblemconfirmation.dart';

class OrdererProblemsPage extends StatefulWidget {
  @override
  _OrdererProblemsPageState createState() => _OrdererProblemsPageState();
}

class _OrdererProblemsPageState extends State<OrdererProblemsPage> {
  List<String> problems = [
    'Late delivery',
    'Wrong item delivered',
    'Item missing',
    'Poor packaging',
    'Other'
  ];
  List<bool> selectedProblems = List<bool>.filled(5, false);

  void submitProblems() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProblemConfirmationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Problems'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the problems you faced:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: problems.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(problems[index]),
                    value: selectedProblems[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedProblems[index] = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: submitProblems,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}