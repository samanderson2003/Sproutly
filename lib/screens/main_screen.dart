import 'package:flutter/material.dart';
import 'package:nursery/screens/cart_screen.dart';
import 'package:nursery/screens/home_screen.dart';
import 'package:nursery/screens/products_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Set the default index to 1 for the "Home" tab
  int _selectedIndex = 1;

  // List of the screens to be displayed
  static const List<Widget> _widgetOptions = <Widget>[
    ProductsScreen(), // Index 0
    HomeScreen(), // Index 1
    CartScreen(), // Index 2
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2D5016),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFFF8F6F0),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}
