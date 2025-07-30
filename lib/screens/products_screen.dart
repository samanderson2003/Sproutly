import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Correct imports based on your file structure
import 'package:nursery/models/product.dart';
import 'package:nursery/providers/cart_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // --- Static Data based on the guide ---
  static final List<Product> _livePlants = [
    const Product(
      name: 'Monstera',
      image: 'assets/plants/monstera_deliciosa.png',
      price: 45.99,
    ),
    const Product(
      name: 'Snake Plant',
      image: 'assets/plants/snake_plant.jpg',
      price: 25.99,
    ),
    const Product(
      name: 'Fiddle Leaf Fig',
      image: 'assets/plants/fiddle_leaf_fig.png',
      price: 65.99,
    ),
    const Product(
      name: 'Peace Lily',
      image: 'assets/plants/peace_lily.jpg',
      price: 32.99,
    ),
    const Product(
      name: 'Rose Bush',
      image: 'assets/plants/rose_bush.jpg',
      price: 22.99,
    ),
  ];

  static final List<Product> _potsAndPlanters = [
    const Product(
      name: 'Ceramic Pot',
      image: 'assets/pots/ceramic_pot.png',
      price: 19.99,
    ),
    const Product(
      name: 'Terracotta Pot',
      image: 'assets/pots/terracotta_pot.png',
      price: 9.99,
    ),
    const Product(
      name: 'Hanging Planter',
      image: 'assets/pots/hanging_planter.png',
      price: 14.99,
    ),
    const Product(
      name: 'Metal Stand',
      image: 'assets/pots/metal_stand.png',
      price: 29.99,
    ),
  ];

  static final List<Product> _gardeningTools = [
    const Product(
      name: 'Hand Trowel',
      image: 'assets/tools/trowel.png',
      price: 7.99,
    ),
    const Product(
      name: 'Pruning Shears',
      image: 'assets/tools/shears.png',
      price: 15.99,
    ),
    const Product(
      name: 'Gardening Gloves',
      image: 'assets/tools/gloves.png',
      price: 10.99,
    ),
    const Product(
      name: 'Watering Can',
      image: 'assets/tools/watering_can.png',
      price: 12.99,
    ),
  ];

  static final List<Product> _soilAndFertilizers = [
    const Product(
      name: 'Potting Mix (5L)',
      image: 'assets/soil/potting_mix.png',
      price: 8.99,
    ),
    const Product(
      name: 'Vermicompost (1kg)',
      image: 'assets/soil/vermicompost.png',
      price: 5.99,
    ),
    const Product(
      name: 'Neem Oil (100ml)',
      image: 'assets/soil/neem_oil.png',
      price: 6.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Products',
          style: TextStyle(
            color: Color(0xFF2D5016),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          _buildSection('Live Plants', _livePlants),
          _buildSection('Pots & Planters', _potsAndPlanters),
          _buildSection('Gardening Tools', _gardeningTools),
          _buildSection('Soil & Fertilizers', _soilAndFertilizers),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D5016),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _ProductCard(product: products[index]);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2D5016),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2D5016),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Color(0xFF2D5016),
                    ),
                    onPressed: () {
                      final cart = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );
                      cart.addItem(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart!'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () => cart.removeItem(product),
                          ),
                        ),
                      );
                    },
                    tooltip: 'Add to cart',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
