class Plant {
  final String name;
  final String image;
  final String category;
  final List<String> suitableWeather;
  final String description;
  final String careLevel;
  final String size;
  final double price;

  Plant({
    required this.name,
    required this.image,
    required this.category,
    required this.suitableWeather,
    required this.description,
    required this.careLevel,
    required this.size,
    required this.price,
  });
}

class PlantData {
  static List<Plant> getAllPlants() {
    return [
      Plant(
        name: 'Monstera Deliciosa',
        image: '🌿',
        category: 'Indoor',
        suitableWeather: ['Clear', 'Clouds', 'Rain'],
        description:
            'Beautiful large-leafed tropical plant perfect for indoor spaces.',
        careLevel: 'Easy',
        size: 'Large',
        price: 45.99,
      ),
      Plant(
        name: 'Snake Plant',
        image: '🐍',
        category: 'Indoor',
        suitableWeather: ['Clear', 'Clouds', 'Rain', 'Snow'],
        description:
            'Low-maintenance plant that purifies air and tolerates low light.',
        careLevel: 'Very Easy',
        size: 'Medium',
        price: 25.99,
      ),
      Plant(
        name: 'Lavender',
        image: '💜',
        category: 'Outdoor',
        suitableWeather: ['Clear', 'Clouds'],
        description:
            'Fragrant herb that attracts bees and has calming properties.',
        careLevel: 'Easy',
        size: 'Small',
        price: 18.99,
      ),
      Plant(
        name: 'Fiddle Leaf Fig',
        image: '🌱',
        category: 'Indoor',
        suitableWeather: ['Clear', 'Clouds'],
        description: 'Statement plant with large, violin-shaped leaves.',
        careLevel: 'Moderate',
        size: 'Large',
        price: 65.99,
      ),
      Plant(
        name: 'Succulent Mix',
        image: '🌵',
        category: 'Indoor/Outdoor',
        suitableWeather: ['Clear', 'Clouds'],
        description:
            'Collection of drought-resistant plants in various shapes.',
        careLevel: 'Easy',
        size: 'Small',
        price: 12.99,
      ),
      Plant(
        name: 'Peace Lily',
        image: '🕊️',
        category: 'Indoor',
        suitableWeather: ['Clear', 'Clouds', 'Rain'],
        description:
            'Elegant flowering plant that thrives in low to medium light.',
        careLevel: 'Easy',
        size: 'Medium',
        price: 32.99,
      ),
    ];
  }
}
