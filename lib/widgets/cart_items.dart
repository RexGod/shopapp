// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../provider/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  CartItem(
      {required this.id,
      required this.productId,
      required this.price,
      required this.title,
      required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: ((_) => AlertDialog(
                  title: const Text('Are you sure'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('NO'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('YES'),
                        )
                      ],
                    )
                  ],
                )));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItems(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
                child: FittedBox(
              child: Text('\$$price'),
            )),
            title: Text(title),
            subtitle: Text('total : ${price * quantity}'),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}
