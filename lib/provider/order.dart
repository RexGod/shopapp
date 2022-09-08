import 'package:flutter/foundation.dart';

import './cart.dart';

class Order with ChangeNotifier  {
  // ignore: prefer_final_fields
  List<OrderItems> _orders = [];

  List<OrderItems> get orders {
    return [..._orders];
  }

  void addOrderItems(List<CartItem> cartProduct, double total) {
    _orders.insert(
        0,
        OrderItems(
            amount: total,
            dateTime: DateTime.now(),
            id: DateTime.now().toString(),
            product: cartProduct));
    notifyListeners();
  }
}

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> product;
  final DateTime dateTime;

  OrderItems(
      {required this.amount,
      required this.dateTime,
      required this.id,
      required this.product});
}
