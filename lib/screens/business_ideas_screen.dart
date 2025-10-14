import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'growth_guides_screen.dart'; // Make sure this file exists
import 'sales_guide_screen.dart'; // Make sure this file exists

// --- Data Model for a single growth venture ---
class GrowthVenture {
  final String name;
  final double seedCost;
  final int growthDays;
  final double potentialRevenue;

  const GrowthVenture({
    required this.name,
    required this.seedCost,
    required this.growthDays,
    required this.potentialRevenue,
  });

  double get potentialProfit => potentialRevenue - seedCost;
  String get growthDuration {
    if (growthDays < 30) {
      return '$growthDays Days';
    } else {
      return '${(growthDays / 30).round()} Months';
    }
  }
}

// --- The Main Screen Widget ---
class BusinessIdeasScreen extends StatefulWidget {
  const BusinessIdeasScreen({super.key});

  @override
  State<BusinessIdeasScreen> createState() => _BusinessIdeasScreenState();
}

class _BusinessIdeasScreenState extends State<BusinessIdeasScreen> {
  // --- Static data ---
  final List<GrowthVenture> _ventures = [
    const GrowthVenture(
      name: 'Basil',
      seedCost: 50.00,
      growthDays: 60,
      potentialRevenue: 1500.00,
    ),
    const GrowthVenture(
      name: 'Cherry Tomatoes',
      seedCost: 80.00,
      growthDays: 90,
      potentialRevenue: 3500.00,
    ),
    const GrowthVenture(
      name: 'Microgreens',
      seedCost: 200.00,
      growthDays: 14,
      potentialRevenue: 2500.00,
    ),
    const GrowthVenture(
      name: 'Lettuce Heads',
      seedCost: 60.00,
      growthDays: 50,
      potentialRevenue: 2000.00,
    ),
    const GrowthVenture(
      name: 'Marigold Flowers',
      seedCost: 100.00,
      growthDays: 75,
      potentialRevenue: 4000.00,
    ),
    const GrowthVenture(
      name: 'Spinach',
      seedCost: 40.00,
      growthDays: 45,
      potentialRevenue: 1800.00,
    ),
  ];

  late GrowthVenture _selectedVenture;

  @override
  void initState() {
    super.initState();
    _selectedVenture = _ventures.first;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D5016);
    const backgroundColor = Color(0xFFF8F6F0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Profit Calculator',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      // ===== CHANGE STARTS HERE: Replaced SingleChildScrollView with Padding and Column =====
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // This Expanded widget takes all available space, pushing the buttons down
            Expanded(
              // ListView ensures content still scrolls on very small screens
              child: ListView(
                children: [
                  // --- GIF / Lottie Animation Section ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset(
                        'assets/business/seeds.json',
                        height: 80,
                        width: 80,
                      ),
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                      Lottie.asset(
                        'assets/business/growth.json',
                        height: 80,
                        width: 80,
                      ),
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                      Lottie.asset(
                        'assets/business/Money.json',
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Select a plant to see its potential',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),

                  // --- Dropdown for Plant Selection ---
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor.withOpacity(0.5)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<GrowthVenture>(
                        value: _selectedVenture,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.park_outlined,
                          color: primaryColor,
                        ),
                        onChanged: (GrowthVenture? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedVenture = newValue;
                            });
                          }
                        },
                        items: _ventures
                            .map<DropdownMenuItem<GrowthVenture>>(
                              (v) => DropdownMenuItem<GrowthVenture>(
                                value: v,
                                child: Text(
                                  v.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Results Section ---
                  _buildMetricCard(
                    icon: Icons.shopping_cart_checkout,
                    label: 'Initial Investment (Seeds, etc.)',
                    value: '₹${_selectedVenture.seedCost.toStringAsFixed(2)}',
                    color: Colors.blueGrey,
                  ),
                  _buildMetricCard(
                    icon: Icons.timelapse,
                    label: 'Estimated Growth Time',
                    value: _selectedVenture.growthDuration,
                    color: Colors.orange,
                  ),
                  _buildMetricCard(
                    icon: Icons.trending_up,
                    label: 'Potential Revenue',
                    value:
                        '₹${_selectedVenture.potentialRevenue.toStringAsFixed(2)}',
                    color: Colors.teal,
                  ),
                  _buildMetricCard(
                    icon: Icons.account_balance_wallet,
                    label: 'Potential Profit',
                    value:
                        '₹${_selectedVenture.potentialProfit.toStringAsFixed(2)}',
                    color: primaryColor,
                    isProfit: true,
                  ),
                ],
              ),
            ),

            // ===== This section is now fixed at the bottom of the screen =====
            const SizedBox(height: 16),
            const Text(
              'Ready for the Next Step?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildNavButtonWithImage(
                    context: context,
                    imagePath: 'assets/guides/diary-book_13323633.png',
                    label: 'Growth Guides',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GrowthGuidesScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNavButtonWithImage(
                    context: context,
                    imagePath: 'assets/guides/shop_10682510.png',
                    label: 'Sales Guide',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SalesGuideScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Adds padding at the very bottom
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for displaying each metric in a card ---
  Widget _buildMetricCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isProfit = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isProfit ? color : Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32, color: isProfit ? Colors.white : color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: isProfit ? Colors.white70 : Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    child: Text(
                      value,
                      key: ValueKey<String>(value),
                      style: TextStyle(
                        color: isProfit ? Colors.white : Colors.black87,
                        fontSize: isProfit ? 24 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for navigation buttons with custom images ---
  Widget _buildNavButtonWithImage({
    required BuildContext context,
    required String imagePath,
    required String label,
    required VoidCallback onPressed,
  }) {
    const primaryColor = Color(0xFF2D5016);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: primaryColor.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to icon if image not found
              return Icon(
                label.contains('Growth')
                    ? Icons.eco_outlined
                    : Icons.storefront_outlined,
                size: 32,
                color: primaryColor,
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
