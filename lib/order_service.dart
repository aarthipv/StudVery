import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void checkout(BuildContext context, List<Map<String, dynamic>> cartItems, String location) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      // Create a new order document in the user's orders sub-collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .add({
        'items': cartItems,
        'location': location,
        'status': 'Pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful and order placed')),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    }
  }
}