import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';
import '../screens/product_detail_screeen.dart';
import '../provider/product.dart';

// ignore: use_key_in_widget_constructors
class ProductItems extends StatelessWidget {
  /* final String title;
  final String imageUrl;
  final String id;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ProductItems(this.id, this.title, this.imageUrl); */
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, product, _) => IconButton(
                icon: product.isFavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                // ignore: deprecated_member_use
                color: Colors.deepOrange,
                onPressed: product.toggleFavorite,
              ),
            ),
            backgroundColor: Colors.black54,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              // ignore: deprecated_member_use
              color: Theme.of(context).accentColor,
              onPressed: () {},
            )),
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