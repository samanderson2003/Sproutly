import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final String condition;
  final double size;

  const WeatherIconWidget({super.key, required this.condition, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft shadow behind icon for 3D floating effect
          Positioned(
            top: size * 0.08,
            left: size * 0.08,
            child: Container(
              width: size * 0.8,
              height: size * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size * 0.4),
                gradient: RadialGradient(
                  colors: [
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Main weather icon
          _buildIcon(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    switch (condition.toLowerCase()) {
      case 'clear':
        return _buildSunnyIcon();
      case 'clouds':
        return _buildCloudyIcon();
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return _buildRainyIcon();
      default:
        return _buildSunnyIcon();
    }
  }

  Widget _buildSunnyIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Sun rays with glow effect
        for (int i = 0; i < 8; i++)
          Transform.rotate(
            angle: (i * 45) * 3.14159 / 180,
            child: Container(
              width: 2,
              height: size * 0.15,
              margin: EdgeInsets.only(bottom: size * 0.35),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFD700).withOpacity(0.9),
                    const Color(0xFFFFD700).withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        // Sun center with multiple layers for depth
        Container(
          width: size * 0.4,
          height: size * 0.4,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                const Color(0xFFFFE55C),
                const Color(0xFFFFD700),
                const Color(0xFFFFA500),
              ],
              stops: const [0.0, 0.7, 1.0],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 3,
              ),
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.2),
                blurRadius: 25,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCloudyIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Back cloud
        Positioned(
          top: size * 0.25,
          left: size * 0.1,
          child: Container(
            width: size * 0.35,
            height: size * 0.25,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  const Color(0xFFE6E6FA).withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(size * 0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        // Front cloud
        Positioned(
          top: size * 0.3,
          right: size * 0.1,
          child: Container(
            width: size * 0.45,
            height: size * 0.3,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  const Color(0xFFF0F8FF).withOpacity(0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(size * 0.25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRainyIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Cloud base
        _buildCloudyIcon(),
        // Rain drops with animation effect
        for (int i = 0; i < 4; i++)
          Positioned(
            bottom: size * 0.15,
            left: size * 0.2 + (i * size * 0.15),
            child: Container(
              width: 1.5,
              height: size * 0.18,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF4682B4).withOpacity(0.8),
                    const Color(0xFF4682B4).withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4682B4).withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
