import 'dart:convert';
import '../models/http_Exeption.dart';
import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts() async {
    var url =
        Uri.https('shopapppra-default-rtdb.firebaseio.com', '/products.json');
    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extractData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imagUrl: prodData['imagUrl'],
            price: prodData['price']));
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newproduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      var url = Uri.https(
          'shopapppra-default-rtdb.firebaseio.com', '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newproduct.title,
            'description': newproduct.description,
            'imagUrl': newproduct.imagUrl,
            'price': newproduct.price
          }));
      _items[prodIndex] = newproduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.https(
        'shopapppra-default-rtdb.firebaseio.com', '/products/$id.json');
    final existingIdIndex = _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingIdIndex];
    _items.removeAt(existingIdIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingIdIndex, existingProduct);
      notifyListeners();
      throw httpExeption('An error acured');
    }
    existingProduct = null;
  }

  Future<void> addProduct(Product product) {
    var url =
        Uri.https('shopapppra-default-rtdb.firebaseio.com', '/products.json');
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'isFavorite': product.isFavorite,
              'imagUrl': product.imagUrl
            }))
        .then((value) {
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imagUrl: product.imagUrl,
        id: json.decode(value.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    });
  }
}
