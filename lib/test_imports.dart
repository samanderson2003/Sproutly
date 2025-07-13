import 'package:flutter/material.dart';
import 'models/weather.dart';
import 'models/plant.dart';
import 'services/weather_service.dart';
import 'widgets/weather_icon_widget.dart';

void main() {
  print('Testing imports...');

  // Test creating instances
  final weather = Weather(
    city: 'Test',
    country: 'Test',
    temperature: 20.0,
    condition: 'Clear',
    description: 'test',
    humidity: 50,
    windSpeed: 5.0,
    icon: '01d',
  );

  print('Weather created: ${weather.city}');

  final plants = PlantData.getAllPlants();
  print('Plants count: ${plants.length}');

  final weatherService = WeatherService();
  print('WeatherService created');
}
