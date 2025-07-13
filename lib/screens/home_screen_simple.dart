import 'package:flutter/material.dart';
import 'package:nursery/models/weather.dart';
import 'package:nursery/models/plant.dart';
import 'package:nursery/services/weather_service.dart';
import 'package:nursery/widgets/weather_icon_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final weather = await _weatherService.getCurrentWeather();
      final plants = PlantData.getAllPlants();

      setState(() {
        _weather = weather;
        _plants = plants;
        _recommendedPlants = plants
            .where(
              (plant) => plant.suitableWeather.contains(
                _weather?.condition ?? 'Clear',
              ),
            )
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _weather = Weather(
          city: 'Your City',
          country: 'XX',
          temperature: 22.0,
          condition: 'Clear',
          description: 'clear sky',
          humidity: 65,
          windSpeed: 3.5,
          icon: '01d',
        );
        _plants = PlantData.getAllPlants();
        _recommendedPlants = _plants;
        _isLoading = false;
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
        title: Text(
          'Sproutly',
          style: TextStyle(
            color: const Color(0xFF2D5016),
            fontSize: 28,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Colors.white.withValues(alpha: 0.8),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.person_outline,
                color: const Color(0xFF2D5016),
                size: 26,
                shadows: [
                  Shadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF2D5016)),
            )
          : RefreshIndicator(
              color: const Color(0xFF2D5016),
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Weather Card
                    _buildWeatherCard(),
                    const SizedBox(height: 24),

                    // Plant Care Tips
                    _buildCareTipsSection(),
                    const SizedBox(height: 24),

                    // Recommended Plants Carousel
                    _buildRecommendedPlantsSection(),
                    const SizedBox(height: 24),

                    // All Plants Grid
                    _buildAllPlantsSection(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildWeatherCard() {
    if (_weather == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 20,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Weather Icon - No background, pure 3D effect
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Soft shadow behind icon for 3D effect
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: RadialGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.1),
                              Colors.transparent,
                            ],
                            stops: const [0.3, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Main weather icon
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: WeatherIconWidget(
                        condition: _weather!.condition,
                        size: 70,
                      ),
                    ),
                  ],
                ),
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
                        height: 1.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            offset: const Offset(0, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _weather!.description.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF666666),
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.white.withValues(alpha: 0.8),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: const Color(0xFF999999).withValues(alpha: 0.8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_weather!.city}, ${_weather!.country}',
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF999999),
                            fontWeight: FontWeight.w400,
                            shadows: [
                              Shadow(
                                color: Colors.white.withValues(alpha: 0.6),
                                offset: const Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Weather details with glassmorphism effect
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherDetail(
                  Icons.water_drop_outlined,
                  'Humidity',
                  '${_weather!.humidity}%',
                ),
                Container(
                  width: 1,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF2D5016).withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                _buildWeatherDetail(
                  Icons.air,
                  'Wind',
                  '${_weather!.windSpeed.round()} m/s',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String label, String value) {
    return Column(
      children: [
        // 3D floating icon effect
        SizedBox(
          width: 36,
          height: 36,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Soft shadow for floating effect
              Positioned(
                top: 3,
                left: 3,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: RadialGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),
              // Icon with subtle glow
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2D5016).withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: const Color(0xFF2D5016), size: 22),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: const Color(0xFF666666),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                color: Colors.white.withValues(alpha: 0.7),
                offset: const Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D5016),
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
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
            color: const Color(0xFF2D5016).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: tips
                .map(
                  (tip) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.tips_and_updates,
                          color: Color(0xFF2D5016),
                          size: 16,
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
          'Perfect for Today\'s Weather',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D5016),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.8),
            itemCount: _recommendedPlants.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
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

  Widget _buildAllPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Plants',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D5016),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _plants.length,
          itemBuilder: (context, index) {
            return _buildPlantCard(_plants[index]);
          },
        ),
      ],
    );
  }

  Widget _buildPlantCard(Plant plant, {bool isCarousel = false}) {
    return Container(
      margin: isCarousel ? const EdgeInsets.symmetric(horizontal: 4) : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  plant.image,
                  style: TextStyle(fontSize: isCarousel ? 80 : 60),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: TextStyle(
                      fontSize: isCarousel ? 16 : 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D5016),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plant.careLevel,
                    style: TextStyle(
                      fontSize: isCarousel ? 12 : 11,
                      color: const Color(0xFF666666),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${plant.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: isCarousel ? 16 : 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D5016),
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        size: isCarousel ? 20 : 18,
                        color: const Color(0xFF2D5016),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
