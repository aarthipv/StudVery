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

class ProblemConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Problem Reported'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Thank you for reporting the problem. We are working to resolve it.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}