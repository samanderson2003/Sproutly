import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final String condition;
  final double size;

  const WeatherIconWidget({
    super.key,
    required this.condition,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        _getWeatherImagePath(condition),
        width: size,
        height: size,
        fit: BoxFit.contain, // Show full icon without cropping
        errorBuilder: (context, error, stackTrace) {
          // Clean fallback without shadows
          return Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getGradientColors(condition),
              ),
            ),
            child: Center(
              child: Text(
                _getFallbackEmoji(condition),
                style: TextStyle(fontSize: size * 0.4),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getWeatherImagePath(String condition) {
    switch (condition.toLowerCase()) {
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
      case 'shower rain':
      case 'light rain':
      case 'moderate rain':
      case 'heavy rain':
        return 'assets/rain_weather.png';
      case 'clear':
      case 'sunny':
      case 'sun':
      case 'bright':
      default:
        return 'assets/sunny_weather.png';
    }
  }

  List<Color> _getGradientColors(String condition) {
    switch (condition.toLowerCase()) {
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
      case 'shower rain':
      case 'light rain':
      case 'moderate rain':
      case 'heavy rain':
        return [const Color(0xFF4A90E2), const Color(0xFF7BB3F0)];
      case 'clouds':
      case 'cloudy':
      case 'overcast':
      case 'partly cloudy':
        return [const Color(0xFF9E9E9E), const Color(0xFFBDBDBD)];
      case 'clear':
      case 'sunny':
      case 'sun':
      case 'bright':
      default:
        return [const Color(0xFFFFD54F), const Color(0xFFFFB74D)];
    }
  }

  String _getFallbackEmoji(String condition) {
    switch (condition.toLowerCase()) {
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
      case 'shower rain':
      case 'light rain':
      case 'moderate rain':
      case 'heavy rain':
        return '🌧️';
      case 'clouds':
      case 'cloudy':
      case 'overcast':
      case 'partly cloudy':
        return '☁️';
      case 'snow':
      case 'sleet':
        return '❄️';
      case 'clear':
      case 'sunny':
      case 'sun':
      case 'bright':
      default:
        return '☀️';
    }
  }
}
