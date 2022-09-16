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

  double get totalAmount {
    var amount = 0.0;
    _items.forEach((key, value) {
      amount += value.price * value.quantity;
    });
    return amount;
  }

  void addItemsToShoppingCart(
      String productId, String producttitle, double productPrice) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              title: value.title,
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

  void removeItems(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  void cleaner() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItems(String itemId) {
    if (!_items.containsKey(itemId)) {
      return;
    }
    if ((_items[itemId]?.quantity)! > 1) {
      _items.update(
          itemId,
          (value) => CartItem(
              title: value.title,
              id: value.id,
              price: value.price,
              quantity: value.quantity - 1));
    } else {
      _items.remove(itemId);
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
