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
      name: 'ZZ Plant',
      image: 'assets/plants/zz_plant.png',
      price: 30.99,
    ),
    const Product(
      name: 'Golden Pothos',
      image: 'assets/plants/golden_pothos.png',
      price: 18.99,
    ),
    const Product(
      name: 'Spider Plant',
      image: 'assets/plants/spider_plant.png',
      price: 15.99,
    ),
    const Product(
      name: 'String of Pearls',
      image: 'assets/plants/string_of_pearls.png',
      price: 24.99,
    ),
    const Product(
      name: 'Calathea Orbifolia',
      image: 'assets/plants/calathea_orbifolia.png',
      price: 38.99,
    ),
    const Product(
      name: 'Bird of Paradise',
      image: 'assets/plants/bird_of_paradise.png',
      price: 75.99,
    ),
    const Product(
      name: 'Rubber Plant',
      image: 'assets/plants/rubber_plant.png',
      price: 42.99,
    ),
    const Product(
      name: 'Aloe Vera',
      image: 'assets/plants/aloe_vera.png',
      price: 14.99,
    ),
    const Product(
      name: 'Phalaenopsis Orchid',
      image: 'assets/plants/orchid.png',
      price: 28.99,
    ),
    const Product(
      name: 'Succulent Pack (x5)',
      image: 'assets/plants/succulent_pack.png',
      price: 20.99,
    ),
    const Product(
      name: 'Monstera',
      image: 'assets/plants/monstera_deliciosa.png',
      price: 45.99,
    ),
    const Product(
      name: 'Snake Plant',
      image: 'assets/plants/snake_plant.png',
      price: 25.99,
    ),
    const Product(
      name: 'Fiddle Leaf Fig',
      image: 'assets/plants/fiddle_leaf_fig.png',
      price: 65.99,
    ),
    const Product(
      name: 'Peace Lily',
      image: 'assets/plants/peace_lily.png',
      price: 32.99,
    ),
    const Product(
      name: 'Rose Bush',
      image: 'assets/plants/rose_bush.png',
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
    const Product(
      name: 'Self-Watering Pot',
      image: 'assets/pots/self_watering_pot.png',
      price: 24.99,
    ),
    const Product(
      name: 'Wooden Planter Box',
      image: 'assets/pots/wooden_planter_box.png',
      price: 35.99,
    ),
    const Product(
      name: 'Concrete Planter',
      image: 'assets/pots/concrete_planter.png',
      price: 22.99,
    ),
    const Product(
      name: 'Wall Planter',
      image: 'assets/pots/wall_planter.png',
      price: 18.99,
    ),
    const Product(
      name: 'Macrame Plant Hanger',
      image: 'assets/pots/macrame_hanger.png',
      price: 12.99,
    ),
    const Product(
      name: 'Window Box',
      image: 'assets/pots/window_box.png',
      price: 28.99,
    ),
    const Product(
      name: 'Fabric Pot (5 Gallon)',
      image: 'assets/pots/fabric_pot.png',
      price: 8.99,
    ),
    const Product(
      name: 'Bonsai Pot',
      image: 'assets/pots/bonsai_pot.png',
      price: 21.99,
    ),
    const Product(
      name: 'Saucer Tray Pack (x3)',
      image: 'assets/pots/saucer_pack.png',
      price: 11.99,
    ),
    const Product(
      name: 'Vertical Garden Planter',
      image: 'assets/pots/vertical_planter.png',
      price: 49.99,
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
    const Product(
      name: 'Hand Cultivator',
      image: 'assets/tools/cultivator.png',
      price: 8.99,
    ),
    const Product(
      name: 'Weeder',
      image: 'assets/tools/weeder.png',
      price: 9.99,
    ),
    const Product(
      name: 'Garden Fork',
      image: 'assets/tools/fork.png',
      price: 18.99,
    ),
    const Product(
      name: 'Kneeling Pad',
      image: 'assets/tools/kneeling_pad.png',
      price: 14.99,
    ),
    const Product(
      name: 'Hose Nozzle',
      image: 'assets/tools/hose_nozzle.png',
      price: 11.99,
    ),
    const Product(
      name: 'Pruning Saw',
      image: 'assets/tools/saw.png',
      price: 22.99,
    ),
    const Product(
      name: 'Wheelbarrow',
      image: 'assets/tools/wheelbarrow.png',
      price: 89.99,
    ),
    const Product(name: 'Spade', image: 'assets/tools/spade.png', price: 25.99),
    const Product(name: 'Rake', image: 'assets/tools/rake.png', price: 19.99),
    const Product(
      name: 'Dibber',
      image: 'assets/tools/dibber.png',
      price: 6.99,
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
    const Product(
      name: 'Orchid Bark Mix',
      image: 'assets/soil/orchid_mix.png',
      price: 12.99,
    ),
    const Product(
      name: 'Cactus Soil Mix',
      image: 'assets/soil/cactus_mix.png',
      price: 9.99,
    ),
    const Product(
      name: 'Perlite (2L)',
      image: 'assets/soil/perlite.png',
      price: 7.99,
    ),
    const Product(
      name: 'Peat Moss',
      image: 'assets/soil/peat_moss.png',
      price: 10.99,
    ),
    const Product(
      name: 'All-Purpose Plant Food',
      image: 'assets/soil/plant_food.png',
      price: 11.99,
    ),
    const Product(
      name: 'Bone Meal (500g)',
      image: 'assets/soil/bone_meal.png',
      price: 8.99,
    ),
    const Product(
      name: 'Blood Meal (500g)',
      image: 'assets/soil/blood_meal.png',
      price: 8.99,
    ),
    const Product(
      name: 'Epsom Salt (1kg)',
      image: 'assets/soil/epsom_salt.png',
      price: 9.99,
    ),
    const Product(
      name: 'Horticultural Charcoal',
      image: 'assets/soil/charcoal.png',
      price: 13.99,
    ),
    const Product(
      name: 'Sphagnum Moss',
      image: 'assets/soil/sphagnum_moss.png',
      price: 10.99,
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
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
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
          // ** CHANGE: Adjusted height for the new card design **
          height: 260,
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

// ** CHANGE: The entire Product Card widget has been updated **
class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // Made cards slightly wider for a better look
      margin: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        onTap: () {
          // Optional: Add navigation to a product detail page here
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Background Image
              Image.asset(product.image, fit: BoxFit.cover),
              // 2. Bottom Gradient for text visibility
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
              // 3. Text and Add to Cart Button
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Product Name and Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add to Cart Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
