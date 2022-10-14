import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';

class Order with ChangeNotifier {
  // ignore: prefer_final_fields
  List<OrderItems> _orders = [];
  final String authToken;

  Order(this.authToken, this._orders);

  List<OrderItems> get orders {
    return [..._orders];
  }

  Future<void> fetchAndStoreOrders() async {
    var url =
        Uri.https('shopapppra-default-rtdb.firebaseio.com', '/orders.json' , {'auth' : authToken});
    final response = await http.get(url);
    final List<OrderItems> loadedOrders = [];
    final extractOrderData = json.decode(response.body) as Map<String, dynamic>;
    extractOrderData.forEach((key, ordersData) {
      loadedOrders.add(OrderItems(
          amount: double.parse(ordersData['amount'].toString()),
          dateTime: DateTime.parse(ordersData['dateTime']),
          id: key,
          product: (ordersData['product'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList()));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrderItems(List<CartItem> cartProduct, double total) async {
    var url =
        Uri.https('shopapppra-default-rtdb.firebaseio.com', '/orders.json');

    final response = await http.post(url,
        body: json.encode({
          'amount': total.toStringAsFixed(2),
          'dateTime': DateTime.now().toIso8601String(),
          'product': cartProduct
              .map((cp) => {
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                    'id': cp.id
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItems(
            amount: total,
            dateTime: DateTime.now(),
            id: json.decode(response.body)['name'],
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
