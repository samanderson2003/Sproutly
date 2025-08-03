import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<List<QueryDocumentSnapshot>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();
  }

  Future<List<QueryDocumentSnapshot>> _fetchOrders() async {
    final user = _auth.currentUser;
    if (user == null) {
      // Return an empty list if no user is logged in
      return [];
    }

    // Query the root 'orders' collection and filter by the 'userId'
    // to get only the orders for the current user.
    final querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .get();

    final docs = querySnapshot.docs;

    // Sort the documents on the client-side to avoid needing a composite index.
    // This prevents the app from crashing if the index is not created in Firebase.
    docs.sort((a, b) {
      final aData = a.data() as Map<String, dynamic>;
      final bData = b.data() as Map<String, dynamic>;
      final aDate = (aData['orderDate'] as Timestamp?)?.toDate();
      final bDate = (bData['orderDate'] as Timestamp?)?.toDate();

      // Handle cases where date might be null
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1; // Put null dates at the end
      if (bDate == null) return -1; // Keep non-null dates at the front

      // Sort descending (newest first)
      return bDate.compareTo(aDate);
    });

    return docs;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D5016);
    const backgroundColor = Color(0xFFF8F6F0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'An error occurred: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'You have no past orders. 🛍️',
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor.withOpacity(0.7),
                ),
              ),
            );
          }

          final orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data() as Map<String, dynamic>;

              // Safe data extraction with default values
              final orderDate = (order['orderDate'] as Timestamp?)?.toDate();
              final formattedDate = orderDate != null
                  ? DateFormat('d MMMM yyyy, h:mm a').format(orderDate)
                  : 'Date not available';
              final totalAmount = (order['totalAmount'] ?? 0.0) as double;
              final items = (order['items'] ?? []) as List<dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  leading: const Icon(Icons.receipt_long, color: primaryColor),
                  title: Text(
                    'Order on $formattedDate',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    'Total: ₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  children: [
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items.map((item) {
                          final product = item as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    product['image'] ??
                                        'assets/placeholder.png',
                                  ),
                                  // Handles cases where an image might not load
                                  onBackgroundImageError: (_, __) {},
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '${product['productName']} (x${product['quantity']})',
                                  ),
                                ),
                                Text(
                                  '₹${((product['price'] ?? 0.0) as num).toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
