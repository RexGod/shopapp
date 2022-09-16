import 'package:flutter/material.dart';
import 'package:shopapp/screens/edit_prouct_screen.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

// ignore: camel_case_types
class productManagerItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  productManagerItems(
      {required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .deleteProduct(id);
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
