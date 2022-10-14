// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';
import '../provider/auth.dart';
import '../screens/product_detail_screeen.dart';
import '../provider/cart.dart';

// ignore: use_key_in_widget_constructors
class ProductItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, product, _) => IconButton(
                  icon: product.isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  // ignore: deprecated_member_use
                  color: Colors.deepOrange,
                  onPressed: () {
                    product.toggleFavorite(authData.token.toString());
                  }),
            ),
            backgroundColor: Colors.black54,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                // ignore: deprecated_member_use
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cart.addItemsToShoppingCart(
                      product.id, product.title, product.price);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Item added to cart'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () => cart.removeSingleItems(product.id)),
                    ),
                  );
                })),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(DetailScreen.routeName, arguments: product.id);
          },
          child: Image.network(
            product.imagUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
