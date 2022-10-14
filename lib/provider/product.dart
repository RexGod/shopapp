import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imagUrl;
  final double price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imagUrl,
      required this.price,
      this.isFavorite = false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token) async {
    final oldStatusFav = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    var url = Uri.https(
        'shopapppra-default-rtdb.firebaseio.com', '/products/$id.json' , {'auth' : token});
    try {
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatusFav);
      }
    } catch (error) {
      _setFavValue(oldStatusFav);
      
    }
  }
}
