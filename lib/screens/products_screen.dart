import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // Method to handle signing out
  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      // Navigate back to the login screen and clear all previous routes
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: const Color(0xFFF8F6F0),
        automaticallyImplyLeading: false, // Hide the back button
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context), // Call the sign-out method
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const Center(
        child: Text('Products Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
