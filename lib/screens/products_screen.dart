import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Correct imports based on your file structure
import 'package:nursery/models/product.dart';
import 'package:nursery/providers/cart_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // --- Static Data based on the guide ---
  // --- Static Data based on the guide with Coimbatore-specific prices ---
  static final List<Product> _livePlants = [
    const Product(
      name: 'ZZ Plant',
      image: 'assets/plants/zz_plant.png',
      price: 349.00, // Roughly $4.20
    ),
    const Product(
      name: 'Golden Pothos',
      image: 'assets/plants/golden_pothos.png',
      price: 180.00, // Roughly $2.20
    ),
    const Product(
      name: 'Spider Plant',
      image: 'assets/plants/spider_plant.png',
      price: 150.00, // Roughly $1.80
    ),
    const Product(
      name: 'String of Pearls',
      image: 'assets/plants/string_of_pearls.png',
      price: 250.00, // Roughly $3.00
    ),
    const Product(
      name: 'Calathea Orbifolia',
      image: 'assets/plants/calathea_orbifolia.png',
      price: 380.00, // Roughly $4.60
    ),
    const Product(
      name: 'Bird of Paradise',
      image: 'assets/plants/bird_of_paradise.png',
      price: 750.00, // Roughly $9.00
    ),
    const Product(
      name: 'Rubber Plant',
      image: 'assets/plants/rubber_plant.png',
      price: 430.00, // Roughly $5.20
    ),
    const Product(
      name: 'Aloe Vera',
      image: 'assets/plants/aloe_vera.png',
      price: 120.00, // Roughly $1.45
    ),
    const Product(
      name: 'Phalaenopsis Orchid',
      image: 'assets/plants/orchid.png',
      price: 400.00, // Roughly $4.80
    ),
    const Product(
      name: 'Succulent Pack (x5)',
      image: 'assets/plants/succulent_pack.png',
      price: 200.00, // Roughly $2.40
    ),
    const Product(
      name: 'Monstera',
      image: 'assets/plants/monstera_deliciosa.png',
      price: 500.00, // Roughly $6.00
    ),
    const Product(
      name: 'Snake Plant',
      image: 'assets/plants/snake_plant.png',
      price: 260.00, // Roughly $3.15
    ),
    const Product(
      name: 'Fiddle Leaf Fig',
      image: 'assets/plants/fiddle_leaf_fig.png',
      price: 650.00, // Roughly $7.80
    ),
    const Product(
      name: 'Peace Lily',
      image: 'assets/plants/peace_lily.png',
      price: 330.00, // Roughly $4.00
    ),
    const Product(
      name: 'Rose Bush',
      image: 'assets/plants/rose_bush.png',
      price: 230.00, // Roughly $2.80
    ),
  ];

  static final List<Product> _potsAndPlanters = [
    const Product(
      name: 'Ceramic Pot',
      image: 'assets/pots/ceramic_pot.png',
      price: 200.00, // Roughly $2.40
    ),
    const Product(
      name: 'Terracotta Pot',
      image: 'assets/pots/terracotta_pot.png',
      price: 100.00, // Roughly $1.20
    ),
    const Product(
      name: 'Hanging Planter',
      image: 'assets/pots/hanging_planter.png',
      price: 150.00, // Roughly $1.80
    ),
    const Product(
      name: 'Metal Stand',
      image: 'assets/pots/metal_stand.png',
      price: 300.00, // Roughly $3.60
    ),
    const Product(
      name: 'Self-Watering Pot',
      image: 'assets/pots/self_watering_pot.png',
      price: 250.00, // Roughly $3.00
    ),
    const Product(
      name: 'Wooden Planter Box',
      image: 'assets/pots/wooden_planter_box.png',
      price: 360.00, // Roughly $4.35
    ),
    const Product(
      name: 'Concrete Planter',
      image: 'assets/pots/concrete_planter.png',
      price: 230.00, // Roughly $2.80
    ),
    const Product(
      name: 'Wall Planter',
      image: 'assets/pots/wall_planter.png',
      price: 190.00, // Roughly $2.30
    ),
    const Product(
      name: 'Macrame Plant Hanger',
      image: 'assets/pots/macrame_hanger.png',
      price: 130.00, // Roughly $1.55
    ),
    const Product(
      name: 'Window Box',
      image: 'assets/pots/window_box.png',
      price: 290.00, // Roughly $3.50
    ),
    const Product(
      name: 'Fabric Pot (5 Gallon)',
      image: 'assets/pots/fabric_pot.png',
      price: 90.00, // Roughly $1.10
    ),
    const Product(
      name: 'Bonsai Pot',
      image: 'assets/pots/bonsai_pot.png',
      price: 220.00, // Roughly $2.65
    ),
    const Product(
      name: 'Saucer Tray Pack (x3)',
      image: 'assets/pots/saucer_pack.png',
      price: 120.00, // Roughly $1.45
    ),
    const Product(
      name: 'Vertical Garden Planter',
      image: 'assets/pots/vertical_planter.png',
      price: 500.00, // Roughly $6.00
    ),
  ];

  static final List<Product> _gardeningTools = [
    const Product(
      name: 'Hand Trowel',
      image: 'assets/gardenTools/trowel.png',
      price: 150.00, // Roughly $1.80
    ),
    const Product(
      name: 'Pruning Shears',
      image: 'assets/gardenTools/shears.png',
      price: 250.00, // Roughly $3.00
    ),
    const Product(
      name: 'Gardening Gloves',
      image: 'assets/gardenTools/gloves.png',
      price: 120.00, // Roughly $1.45
    ),
    const Product(
      name: 'Watering Can',
      image: 'assets/gardenTools/watering_can.png',
      price: 130.00, // Roughly $1.55
    ),
    const Product(
      name: 'Hand Cultivator',
      image: 'assets/gardenTools/cultivator.png',
      price: 90.00, // Roughly $1.10
    ),
    const Product(
      name: 'Weeder',
      image: 'assets/gardenTools/weeder.png',
      price: 100.00, // Roughly $1.20
    ),
    const Product(
      name: 'Garden Fork',
      image: 'assets/gardenTools/fork.png',
      price: 190.00, // Roughly $2.30
    ),
    const Product(
      name: 'Kneeling Pad',
      image: 'assets/gardenTools/kneeling_pad.png',
      price: 150.00, // Roughly $1.80
    ),
    const Product(
      name: 'Hose Nozzle',
      image: 'assets/gardenTools/hose_nozzle.png',
      price: 120.00, // Roughly $1.45
    ),
    const Product(
      name: 'Pruning Saw',
      image: 'assets/gardenTools/saw.png',
      price: 230.00, // Roughly $2.80
    ),
    const Product(
      name: 'Wheelbarrow',
      image: 'assets/gardenTools/wheelbarrow.png',
      price: 8900.00, // High-priced item, adjusted significantly
    ),
    const Product(
      name: 'Spade',
      image: 'assets/gardenTools/.png',
      price: 260.00, // Roughly $3.15
    ),
    const Product(
      name: 'Rake',
      image: 'assets/gardenTools/rake.png',
      price: 200.00, // Roughly $2.40
    ),
    const Product(
      name: 'Dibber',
      image: 'assets/gardenTools/dibber.png',
      price: 70.00, // Roughly $0.85
    ),
  ];

  static final List<Product> _soilAndFertilizers = [
    const Product(
      name: 'Potting Mix (5L)',
      image: 'assets/soil/potting_mix.png',
      price: 100.00, // Per 5kg bag
    ),
    const Product(
      name: 'Vermicompost (1kg)',
      image: 'assets/soil/vermicompost.png',
      price: 75.00, // Per 1kg bag
    ),
    const Product(
      name: 'Neem Oil (100ml)',
      image: 'assets/soil/neem_oil.png',
      price: 80.00, // Roughly $0.95
    ),
    const Product(
      name: 'Orchid Bark Mix',
      image: 'assets/soil/orchid_mix.png',
      price: 150.00, // Roughly $1.80
    ),
    const Product(
      name: 'Cactus Soil Mix',
      image: 'assets/soil/cactus_mix.png',
      price: 110.00, // Roughly $1.30
    ),
    const Product(
      name: 'Perlite (2L)',
      image: 'assets/soil/perlite.png',
      price: 85.00, // Roughly $1.00
    ),
    const Product(
      name: 'Peat Moss',
      image: 'assets/soil/peat_moss.png',
      price: 120.00, // Roughly $1.45
    ),
    const Product(
      name: 'All-Purpose Plant Food',
      image: 'assets/soil/plant_food.png',
      price: 120.00, // Roughly $1.45
    ),
    const Product(
      name: 'Bone Meal (500g)',
      image: 'assets/soil/bone_meal.png',
      price: 90.00, // Roughly $1.10
    ),
    const Product(
      name: 'Blood Meal (500g)',
      image: 'assets/soil/blood_meal.png',
      price: 90.00, // Roughly $1.10
    ),
    const Product(
      name: 'Epsom Salt (1kg)',
      image: 'assets/soil/epsom_salt.png',
      price: 100.00, // Roughly $1.20
    ),
    const Product(
      name: 'Horticultural Charcoal',
      image: 'assets/soil/charcoal.png',
      price: 140.00, // Roughly $1.70
    ),
    const Product(
      name: 'Sphagnum Moss',
      image: 'assets/soil/sphagnum_moss.png',
      price: 110.00, // Roughly $1.30
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0), // Home page background color
      appBar: AppBar(
        title: const Text(
          'All Products',
          style: TextStyle(
            color: Color(0xFF2D5016), // Home page title color
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
              color: Color(0xFF2D5016), // Home page section header color
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
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

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
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
              // 2. Bottom Gradient for text visibility (reverted to black)
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
                            '₹${product.price.toStringAsFixed(2)}',
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
                              backgroundColor: const Color(0xFF2D5016),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () => cart.removeItem(product),
                                textColor: const Color(0xFFF8F6F0),
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
