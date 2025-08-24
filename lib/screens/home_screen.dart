import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:nursery/screens/community_chat_screen.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../widgets/weather_icon_widget.dart';
import 'package:nursery/screens/news_screen.dart';

// Import your DiseaseIdentifierScreen
import '../screens/disease_identifier_screen.dart';

// Your Plant and PlantData classes remain the same...
class Plant {
  final String name;
  final String image;
  final String category;
  final List<String> suitableWeather;
  final String description;
  final String size;
  final String climateReasoning;

  Plant({
    required this.name,
    required this.image,
    required this.category,
    required this.suitableWeather,
    required this.description,
    required this.size,
    required this.climateReasoning,
  });
}

class PlantData {
  static List<Plant> getAllPlants() {
    return [
      Plant(
        name: 'Monstera Deliciosa',
        image: 'assets/plants/monstera deliciosa.png',
        category: 'Indoor',
        suitableWeather: ['Clear', 'Clouds', 'Rain', 'Drizzle', 'Mist'],
        description:
            'Beautiful large-leafed tropical plant perfect for indoor spaces. Thrives in bright, indirect light and high humidity.',
        size: 'Large',
        climateReasoning:
            'Prefers bright, indirect light and moderate humidity, which aligns with Clear, Clouds, and Mist conditions.',
      ),
      Plant(
        name: 'Snake Plant',
        image: 'assets/plants/Snake Plant.jpg',
        category: 'Indoor',
        suitableWeather: [
          'Clear',
          'Clouds',
          'Rain',
          'Drizzle',
          'Snow',
          'Mist',
          'Haze',
          'Fog',
          'Thunderstorm',
        ],
        description:
            'Low-maintenance plant that purifies air and tolerates low light. Extremely forgiving.',
        size: 'Medium',
        climateReasoning:
            'Extremely tolerant to various weather types including poor lighting and humidity fluctuations.',
      ),
      Plant(
        name: 'Lavender',
        image: 'assets/plants/lavender.jpg',
        category: 'Outdoor',
        suitableWeather: ['Clear', 'Clouds', 'Haze'],
        description:
            'Fragrant herb that attracts bees and has calming properties. Needs full sun and well-drained soil.',
        size: 'Small',
        climateReasoning:
            'Thrives in sunny and dry conditions, making Clear and Haze ideal for growth.',
      ),
      Plant(
        name: 'Fiddle Leaf Fig',
        image: 'assets/plants/Fiddle Leaf Fig.png',
        category: 'Indoor',
        suitableWeather: ['Clear', 'Clouds', 'Mist'],
        description:
            'Statement plant with large, violin-shaped leaves. Can be a bit finicky but rewarding.',
        size: 'Large',
        climateReasoning:
            'Loves humidity and indirect light, best grown in Misty or Cloudy indoor environments.',
      ),
      Plant(
        name: 'Succulent Mix',
        image: 'assets/plants/Succulent Mix.jpg',
        category: 'Indoor/Outdoor',
        suitableWeather: ['Clear', 'Clouds'],
        description:
            'Collection of drought-resistant plants in various shapes. Perfect for sunny spots.',
        size: 'Small',
        climateReasoning:
            'Designed for dry, arid climates — excels in sunny conditions with minimal water.',
      ),
      Plant(
        name: 'Peace Lily',
        image: 'assets/plants/Peace Lily.jpg',
        category: 'Indoor',
        suitableWeather: [
          'Clear',
          'Clouds',
          'Rain',
          'Drizzle',
          'Mist',
          'Thunderstorm',
        ],
        description:
            'Elegant flowering plant that thrives in low to medium light. Improves air quality.',
        size: 'Medium',
        climateReasoning:
            'Prefers high humidity and consistent moisture, making rainy and misty climates ideal.',
      ),
      Plant(
        name: 'Cactus Assortment',
        image: 'assets/plants/Cactus Assortment.png',
        category: 'Indoor/Outdoor',
        suitableWeather: ['Clear'],
        description:
            'A variety of desert cacti, ideal for bright, arid environments. Very low water needs.',
        size: 'Small',
        climateReasoning:
            'Best suited for hot, dry, and sunny weather — Clear is optimal for cactus growth.',
      ),
      Plant(
        name: 'Fern (Boston)',
        image: 'assets/plants/Fern (Boston).png',
        category: 'Indoor',
        suitableWeather: ['Clouds', 'Rain', 'Drizzle', 'Mist', 'Fog'],
        description:
            'Lush, feathery fern that loves humidity. Perfect for bathrooms or shaded areas.',
        size: 'Medium',
        climateReasoning:
            'Grows well in cool, damp, and humid environments — thrives under cloud cover and mist.',
      ),
      Plant(
        name: 'Orchid (Phalaenopsis)',
        image: 'assets/plants/Orchid (Phalaenopsis).jpg',
        category: 'Indoor',
        suitableWeather: ['Clear', 'Clouds', 'Mist', 'Haze'],
        description:
            'Exotic and elegant flowering plant. Needs bright, indirect light and consistent care.',
        size: 'Small',
        climateReasoning:
            'Stable temperature and humidity help orchids bloom consistently — mist and haze support their growth.',
      ),
      Plant(
        name: 'Sunflower',
        image: 'assets/plants/Sunflower.jpg',
        category: 'Outdoor',
        suitableWeather: ['Clear'],
        description:
            'Iconic, cheerful flower that tracks the sun. Great for gardens.',
        size: 'Large',
        climateReasoning:
            'Demands full sun and warmth — thrives in open, dry, and bright Clear conditions.',
      ),
      Plant(
        name: 'Rose Bush',
        image: 'assets/plants/Rose Bush.jpg',
        category: 'Outdoor',
        suitableWeather: ['Clear', 'Clouds', 'Rain'],
        description:
            'Classic garden favorite known for its beautiful and fragrant flowers.',
        size: 'Medium',
        climateReasoning:
            'Roses grow well with moderate sun and can tolerate occasional rain or cloudy weather.',
      ),
    ];
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = true;
  List<Plant> _plants = [];
  List<Plant> _recommendedPlants = [];

  late PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.90);
    _loadData();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_recommendedPlants.isNotEmpty) {
        _currentPage = (_currentPage + 1) % _recommendedPlants.length;
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  Future<void> _loadData() async {
    try {
      final weather = await _weatherService.getCurrentWeather();
      final plants = PlantData.getAllPlants();

      if (weather != null) {
        setState(() {
          _weather = weather;
          _plants = plants;
          _recommendedPlants = plants
              .where(
                (plant) => plant.suitableWeather.contains(weather.condition),
              )
              .toList();
          _isLoading = false;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          _startAutoScroll();
        });
      } else {
        throw Exception('Weather data is null');
      }
    } catch (e) {
      setState(() {
        _weather = Weather(
          city: 'Coimbatore',
          country: 'India',
          temperature: 28.0,
          condition: 'Clear',
          description: 'clear sky',
          humidity: 60,
          windSpeed: 2.5,
          icon: '01d',
        );
        _plants = PlantData.getAllPlants();
        _recommendedPlants = _plants;
        _isLoading = false;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        _startAutoScroll();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chat_bubble_outline,
            color: const Color(0xFF2D5016),
            size: 26,
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.8),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CommunityChatScreen(),
              ),
            );
          },
          tooltip: 'Community Chat',
        ),
        title: Text(
          'Sproutly',
          style: TextStyle(
            color: const Color(0xFF2D5016),
            fontSize: 28,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.8),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        centerTitle: true,
        // **MODIFIED PART**: Added the actions property for the news button
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              icon: Icon(
                Icons.article_outlined,
                color: const Color(0xFF2D5016),
                size: 26,
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.8),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()),
                );
              },
              tooltip: 'Gardening News',
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _isLoading
              ? Center(
                  child: Lottie.asset(
                    'assets/loading.json',
                    width: 200,
                    height: 200,
                  ),
                )
              : RefreshIndicator(
                  color: const Color(0xFF2D5016),
                  onRefresh: _loadData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWeatherCard(),
                        const SizedBox(height: 24),
                        _buildCareTipsSection(),
                        const SizedBox(height: 24),
                        _buildRecommendedPlantsSection(),
                      ],
                    ),
                  ),
                ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DiseaseIdentifierScreen(),
                  ),
                );
              },
              child: Lottie.asset(
                'assets/Green Robot.json',
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    if (_weather == null) return const SizedBox();
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: WeatherIconWidget(condition: _weather!.condition, size: 80),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_weather!.temperature.round()}°',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF2D5016),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _weather!.description.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Color(0xFF999999),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${_weather!.city}, ${_weather!.country}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareTipsSection() {
    if (_weather == null) return const SizedBox();
    final tips = _weatherService.getWeatherTips(
      _weather!.condition,
      _weather!.temperature,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Plant Care Tips',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D5016),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2D5016).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: tips
                .map(
                  (tip) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.tips_and_updates,
                          size: 16,
                          color: Color(0xFF2D5016),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            tip,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2D5016),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perfect to Grow for This Climate',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D5016),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              _startAutoScroll();
            },
            itemCount: _recommendedPlants.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: _buildPlantCard(
                  _recommendedPlants[index],
                  isCarousel: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlantCard(Plant plant, {bool isCarousel = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          // Image
          Image.asset(
            plant.image,
            width: double.infinity,
            height: 280,
            fit: BoxFit.cover,
          ),
          // Gradient at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 92,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color.fromARGB(220, 44, 80, 22)],
                ),
              ),
            ),
          ),
          // Text overlay
          Positioned(
            left: 18,
            right: 18,
            bottom: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.category,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  plant.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  plant.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // See more button (optional)
          Positioned(
            bottom: 18,
            right: 18,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.93),
              radius: 19,
              child: Icon(
                Icons.arrow_forward,
                color: Color(0xFF2D5016),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
