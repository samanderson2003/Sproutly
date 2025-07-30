// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<Product, int> _items = {};

  Map<Product, int> get items => {..._items};

  int get itemCount {
    return _items.values.fold(0, (sum, quantity) => sum + quantity);
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product)) {
      // Increase quantity
      _items.update(product, (existingValue) => existingValue + 1);
    } else {
      // Add new item
      _items.putIfAbsent(product, () => 1);
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    if (!_items.containsKey(product)) {
      return;
    }
    if (_items[product]! > 1) {
      // Decrease quantity
      _items.update(product, (existingValue) => existingValue - 1);
    } else {
      // Remove item completely
      _items.remove(product);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
