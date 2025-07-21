import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/weather.dart';

class WeatherService {
  static const String _apiKey = '5ec35ad4d1fac7e0805e80470a1bd658';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather?> getCurrentWeather() async {
    try {
      print('🌍 Getting location...');
      // Get current position
      Position position = await _getCurrentPosition();
      print(
        '📍 Location obtained: ${position.latitude}, ${position.longitude}',
      );

      // Fetch weather data
      final url =
          '$_baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$_apiKey&units=metric';
      print('🌐 Calling weather API: $url');

      final response = await http.get(Uri.parse(url));
      print('📡 API Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('✅ Weather data parsed successfully');
        return Weather.fromJson(data);
      } else {
        print('❌ API Error: ${response.statusCode} - ${response.body}');
        return _getDefaultWeather();
      }
    } catch (e) {
      print('❌ Weather service error: $e');
      // Return default weather data if API fails
      return _getDefaultWeather();
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Weather _getDefaultWeather() {
    return Weather(
      city: 'Coimbatore',
      country: 'India',
      temperature: 28.0,
      condition: 'Clear',
      description: 'clear sky',
      humidity: 60,
      windSpeed: 2.5,
      icon: '01d',
    );
  }

  String getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/sunny_weather.png';
      case 'clouds':
        return 'assets/cloud_weather.png';
      case 'rain':
      case 'drizzle':
        return 'assets/rain_weather.png';
      case 'thunderstorm':
        return 'assets/rain_weather.png';
      case 'snow':
        return 'assets/cloud_weather.png';
      case 'mist':
      case 'fog':
        return 'assets/cloud_weather.png';
      default:
        return 'assets/sunny_weather.png';
    }
  }

  List<String> getWeatherTips(String condition, double temperature) {
    List<String> tips = [];

    switch (condition.toLowerCase()) {
      case 'clear':
        if (temperature > 25) {
          tips.addAll([
            'Water your plants early morning or evening',
            'Provide shade for sensitive plants',
            'Check soil moisture regularly',
          ]);
        } else {
          tips.addAll([
            'Perfect weather for outdoor planting',
            'Great time for plant maintenance',
            'Consider moving indoor plants outside',
          ]);
        }
        break;
      case 'rain':
        tips.addAll([
          'Bring potted plants indoors if heavy rain',
          'Ensure good drainage for outdoor plants',
          'Skip watering today - nature\'s got it covered!',
        ]);
        break;
      case 'clouds':
        tips.addAll([
          'Great conditions for repotting',
          'Perfect weather for most plants',
          'Good time for fertilizing',
        ]);
        break;
      case 'snow':
        tips.addAll([
          'Protect outdoor plants from frost',
          'Bring sensitive plants indoors',
          'Reduce watering frequency',
        ]);
        break;
      default:
        tips.addAll([
          'Monitor your plants regularly',
          'Adjust care based on conditions',
          'Keep plants healthy and happy',
        ]);
    }

    return tips;
  }
}
