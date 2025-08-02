import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Use these robust import paths
import 'package:nursery/models/product.dart';
import 'package:nursery/providers/cart_provider.dart';
import 'package:nursery/screens/payment_screen.dart'; // Import the new payment screen

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    Provider.of<CartProvider>(context, listen: false).clear();
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F6F0,
      ), // Set background color to the off-white from the homepage
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Color(0xFF2D5016), // Use the primary green accent color
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Colors.transparent, // Transparent to show the scaffold color
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Color(
                0xFF2D5016,
              ), // Use the green accent color for the icon
            ),
            onPressed: () => _signOut(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty! 🛒',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(
                    0xFF2D5016,
                  ).withOpacity(0.6), // Use a lighter shade of the accent color
                ),
              ),
            );
          }
          final cartItems = cart.items.entries.toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: cartItems.length,
                  itemBuilder: (ctx, i) {
                    final product = cartItems[i].key;
                    final quantity = cartItems[i].value;
                    return Card(
                      color: Colors.white.withOpacity(
                        0.7,
                      ), // Use a semi-transparent white card color
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(product.image),
                          backgroundColor: Colors.white, // Ensures a clean look
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(
                            color: Color(
                              0xFF2D5016,
                            ), // Use the green accent for the title
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Total: ₹${(product.price * quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Color(
                              0xFF666666,
                            ), // Use a neutral gray for subtitle text
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildCartActionButton(
                              icon: Icons.remove,
                              onPressed: () => cart.removeItem(product),
                              tooltip: 'Remove one',
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                color: Color(
                                  0xFF2D5016,
                                ), // Use green accent for quantity
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _buildCartActionButton(
                              icon: Icons.add,
                              onPressed: () => cart.addItem(product),
                              tooltip: 'Add one',
                            ),
                            _buildCartActionButton(
                              icon: Icons.delete,
                              onPressed: () => cart.removeProduct(product),
                              tooltip: 'Remove all',
                              color: Colors.red.withOpacity(
                                0.7,
                              ), // A muted red for delete
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildCartSummary(context, cart),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    String? tooltip,
    Color color = const Color(0xFF2D5016), // Default to accent green
  }) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
      tooltip: tooltip,
      splashRadius: 20,
    );
  }

  Widget _buildCartSummary(BuildContext context, CartProvider cart) {
    return Card(
      color: Colors.white.withOpacity(0.7), // Use semi-transparent white
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5016), // Use green accent
                  ),
                ),
                Text(
                  '₹${cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5016), // Use green accent
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D5016), // Use green accent
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: cart.items.isEmpty
                    ? null
                    : () {
                        // **MODIFIED PART**
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentScreen(),
                          ),
                        );
                      },
                child: const Text(
                  'PROCEED TO CHECKOUT',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
