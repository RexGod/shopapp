import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get counter {
    return _items.length;
  }

  void addItemsToShoppingCart(
      String productId, String producttitle, double productPrice) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              title: value.id,
              id: value.id,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              title: producttitle,
              id: DateTime.now().toString(),
              price: productPrice,
              quantity: 1));
    }
    notifyListeners();
  }
}

class CartItem {
  final String title;
  final double price;
  final int quantity;
  final String id;

  CartItem(
      {required this.title,
      required this.id,
      required this.price,
      required this.quantity});
}
