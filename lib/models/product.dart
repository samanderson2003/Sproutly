// lib/models/product.dart
import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String name;
  final String image;
  final double price;

  const Product({required this.name, required this.image, required this.price});

  // Override hashCode and == for proper object comparison in the cart
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
