// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/order_screen.dart';
import '../provider/cart.dart' show Cart;
import '../widgets/cart_items.dart';
import '../provider/order.dart' as ord;

// ignore: use_key_in_widget_constructors
class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';
  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('your cart')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${carts.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium
                              ?.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<ord.Order>(context, listen: false)
                            .addOrderItems(
                                carts.items.values.toList(), carts.totalAmount);
                        carts.cleaner();
                        Navigator.of(context).pushNamed(Order.routeName);
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: carts.items.length,
                  itemBuilder: (context, index) => CartItem(
                        id: carts.items.values.toList()[index].id,
                        productId: carts.items.keys.toList()[index],
                        price: carts.items.values.toList()[index].price,
                        quantity: carts.items.values.toList()[index].quantity,
                        title: carts.items.values.toList()[index].title,
                      )))
        ],
      ),
    );
  }
}
