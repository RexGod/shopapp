import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import '../widgets/product_items.dart';

// ignore: use_key_in_widget_constructors
class GridViewProduct extends StatelessWidget {
  final bool isFavorite;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  GridViewProduct(this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final productData = isFavorite ? products.favoriteItems : products.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: productData[index],
              child: ProductItems(
                  // productData[index].id,
                  // productData[index].title,
                  // productData[index].imageUrl,
                  ),
            ),
        itemCount: productData.length);
  }
}
