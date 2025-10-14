import 'package:flutter/material.dart';

// --- Data Model for a single plant guide ---
class PlantGuide {
  final String name;
  final String imageAsset; // To show a picture of the plant
  final String sowingDetails;
  final String careDetails;
  final String harvestingDetails;
  final String pestControlDetails;

  const PlantGuide({
    required this.name,
    required this.imageAsset,
    required this.sowingDetails,
    required this.careDetails,
    required this.harvestingDetails,
    required this.pestControlDetails,
  });
}

// --- The Main Screen Widget ---
class GrowthGuidesScreen extends StatefulWidget {
  const GrowthGuidesScreen({super.key});

  @override
  State<GrowthGuidesScreen> createState() => _GrowthGuidesScreenState();
}

class _GrowthGuidesScreenState extends State<GrowthGuidesScreen> {
  // --- Static data for the guides ---
  // NOTE: You need to add the images to your assets folder and pubspec.yaml
  final List<PlantGuide> _guides = [
    const PlantGuide(
      name: 'Microgreens',
      imageAsset: 'assets/guides/microgreens.png',
      sowingDetails:
          'Use a shallow tray with drainage holes. Fill with 2-3 inches of potting mix. Moisten the soil, then sprinkle seeds evenly and densely across the surface. Gently press them into the soil without burying them.',
      careDetails:
          'Mist the seeds 1-2 times daily to keep them moist. Cover the tray with a lid or another tray for the first 2-3 days to create a dark, humid environment for germination. Once sprouted, provide at least 4-6 hours of indirect sunlight.',
      harvestingDetails:
          'Harvest in 10-14 days when the first set of true leaves appears. Use sharp scissors to cut the greens just above the soil line. Rinse gently before serving.',
      pestControlDetails:
          'Generally pest-free due to their short growth cycle. Ensure good air circulation to prevent mold. If mold appears, try a diluted hydrogen peroxide spray.',
    ),
    const PlantGuide(
      name: 'Cherry Tomatoes',
      imageAsset: 'assets/guides/tomatoes.png',
      sowingDetails:
          'Start seeds indoors 6-8 weeks before the last frost. Plant seeds 1/4 inch deep in seed-starting mix. Transplant seedlings to larger pots (at least 5 gallons) when they have 2-3 sets of true leaves.',
      careDetails:
          'Requires 6-8 hours of direct sunlight daily. Water deeply and consistently, aiming for 1-2 inches per week. Avoid getting leaves wet. Use a stake or cage for support as the plant grows. Fertilize every 2-3 weeks.',
      harvestingDetails:
          'Harvest when tomatoes are firm, fully colored, and pull easily from the vine. They ripen over a long period, so check plants every couple of days.',
      pestControlDetails:
          'Watch for aphids and hornworms. Aphids can be washed off with a strong spray of water. Hornworms can be picked off by hand. Companion planting with basil or marigolds can help deter pests.',
    ),
    const PlantGuide(
      name: 'Basil',
      imageAsset: 'assets/guides/basil.png',
      sowingDetails:
          'Sow seeds 1/4 inch deep in well-draining soil. Can be started indoors 6 weeks before the last frost or sown directly outside when the weather is warm. Space plants about 10-12 inches apart.',
      careDetails:
          'Loves heat and at least 6-8 hours of direct sunlight per day. Keep the soil consistently moist, but not waterlogged. Water at the base of the plant to prevent fungal diseases.',
      harvestingDetails:
          'Begin harvesting leaves once the plant is 6-8 inches tall. Pinch off the top set of leaves regularly to encourage bushier growth. The more you harvest, the more it will produce.',
      pestControlDetails:
          'Susceptible to aphids and spider mites. A spray of insecticidal soap can manage them. Ensure good air circulation to avoid powdery mildew.',
    ),
  ];

  late PlantGuide _selectedGuide;

  @override
  void initState() {
    super.initState();
    _selectedGuide = _guides.first;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D5016);
    const backgroundColor = Color(0xFFF8F6F0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Growth Guides',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // --- Dropdown for Plant Selection ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryColor.withOpacity(0.5)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PlantGuide>(
                value: _selectedGuide,
                isExpanded: true,
                icon: const Icon(Icons.grass, color: primaryColor),
                onChanged: (PlantGuide? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedGuide = newValue;
                    });
                  }
                },
                items: _guides.map<DropdownMenuItem<PlantGuide>>((guide) {
                  return DropdownMenuItem<PlantGuide>(
                    value: guide,
                    child: Text(
                      guide.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Use an AnimatedSwitcher for a smooth fade when changing guides
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Column(
              // Use the guide's name as a key to trigger the animation
              key: ValueKey<String>(_selectedGuide.name),
              children: [
                // --- Plant Image ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    _selectedGuide.imageAsset,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Error builder for when images are not found
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // --- Guide Sections ---
                _buildGuideSection(
                  icon: Icons.grain,
                  title: 'Sowing & Soil',
                  content: _selectedGuide.sowingDetails,
                  iconColor: Colors.brown.shade400,
                ),
                _buildGuideSection(
                  icon: Icons.thermostat_auto,
                  title: 'Care & Sunlight',
                  content: _selectedGuide.careDetails,
                  iconColor: Colors.orange.shade600,
                ),
                _buildGuideSection(
                  icon: Icons.content_cut,
                  title: 'Harvesting',
                  content: _selectedGuide.harvestingDetails,
                  iconColor: Colors.green.shade600,
                ),
                _buildGuideSection(
                  icon: Icons.bug_report_outlined,
                  title: 'Pest Control',
                  content: _selectedGuide.pestControlDetails,
                  iconColor: Colors.red.shade400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for displaying each guide section ---
  Widget _buildGuideSection({
    required IconData icon,
    required String title,
    required String content,
    required Color iconColor,
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
                Icon(icon, size: 28, color: iconColor),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5, // Improves readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}
