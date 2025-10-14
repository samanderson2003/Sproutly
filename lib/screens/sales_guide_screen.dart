import 'package:flutter/material.dart';

// --- The Main Screen Widget ---
class SalesGuideScreen extends StatelessWidget {
  const SalesGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D5016);
    const backgroundColor = Color(0xFFF8F6F0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Sales & Marketplace Guide',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildGuideCard(
            icon: Icons.storefront_outlined,
            title: 'Where to Sell Your Plants',
            iconColor: Colors.teal.shade600,
            points: [
              '**Local Farmers\' Markets:** A great way to connect with the community and get instant feedback.',
              '**Online (Social Media):** Use Instagram or Facebook Marketplace to showcase your plants with beautiful photos.',
              '**Local Restaurants & Cafes:** Chefs often look for fresh, local herbs like basil and microgreens.',
              '**Community Groups:** Post in local gardening or neighborhood groups online.',
              '**Roadside Stall:** If you have a suitable location, a simple stall can attract a lot of customers.',
            ],
          ),
          _buildGuideCard(
            icon: Icons.price_change_outlined,
            title: 'Pricing Your Plants',
            iconColor: Colors.orange.shade700,
            points: [
              '**Calculate Your Costs:** Add up the cost of seeds, soil, pots, and water.',
              '**Research Competitors:** See what similar plants are selling for at local nurseries or markets.',
              '**Factor in Your Time:** Don\'t forget to value the time and effort you put into growing.',
              '**Offer Bundles:** Create deals like "3 Herb Pots for ₹500" to encourage larger sales.',
            ],
          ),
          _buildGuideCard(
            icon: Icons.campaign_outlined,
            title: 'Simple Marketing Tips',
            iconColor: Colors.blue.shade600,
            points: [
              '**Take High-Quality Photos:** Good lighting is key. Natural sunlight works best.',
              '**Create Simple Labels:** Include the plant name and basic care instructions (e.g., "Needs Sunlight").',
              '**Start an Instagram Page:** Post progress pictures, from seed to sale, to build a following.',
              '**Word of Mouth:** Tell your friends and family! Offer them a small "friends & family" discount.',
            ],
          ),
          _buildGuideCard(
            icon: Icons.shopping_basket_outlined,
            title: 'Essential Supplies Checklist',
            iconColor: Colors.purple.shade500,
            points: [
              '**Quality Seeds:** Start with good seeds from a reputable supplier.',
              '**Pots & Trays:** Various sizes for different plants. Biodegradable pots are a great selling point.',
              '**Potting Mix:** A good quality, all-purpose mix is essential.',
              '**Simple Packaging:** Paper bags or small boxes for customers to carry their plants home.',
              '**Payment Method:** Decide if you will accept cash only or use a UPI QR code for digital payments.',
            ],
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for displaying each guide card ---
  Widget _buildGuideCard({
    required IconData icon,
    required String title,
    required Color iconColor,
    required List<String> points,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: iconColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...points.map((point) => _buildPoint(point)).toList(),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for formatting each bullet point ---
  // This allows for simple Markdown-like bolding with **text**
  Widget _buildPoint(String text) {
    List<TextSpan> spans = [];
    final parts = text.split('**');

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 1) {
        // This is the bolded part
        spans.add(
          TextSpan(
            text: parts[i],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      } else {
        spans.add(TextSpan(text: parts[i]));
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5.0, right: 8.0),
            child: Icon(Icons.circle, size: 8, color: Colors.black54),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
                children: spans,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
