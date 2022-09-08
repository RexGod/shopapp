import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

// ignore: use_key_in_widget_constructors
class DetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetails';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final productLoaded = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(productLoaded.title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  productLoaded.imagUrl,
                  fit: BoxFit.cover,
                ),
                Text(
                  productLoaded.title,
                  style: TextStyle(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            Text(
              productLoaded.description,
            ),
            Text('Price : \$ ${productLoaded.price}')
          ],
        ),
      ),
    );
  }
}
