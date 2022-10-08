import 'package:flutter/material.dart';
import './edit_prouct_screen.dart';
import 'package:shopapp/widgets/drawer.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/product_manager_item.dart';

// ignore: use_key_in_widget_constructors
class ProductMangaerScreen extends StatelessWidget {
  static const routeName = '/productManager';
  Future <void> _pullReferesh(BuildContext context) async{
   await Provider.of<ProductProvider>(context , listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _pullReferesh(context) ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: ((_, index) => productManagerItems(
                id: productData.items[index].id,
                  title: productData.items[index].title,
                  imageUrl: productData.items[index].imagUrl))),
        ),
      ),
    );
  }
}
