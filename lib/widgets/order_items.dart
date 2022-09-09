import 'dart:math';

import 'package:flutter/material.dart';
import '../provider/order.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItems order;
  // ignore: use_key_in_widget_constructors
  const OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              // ignore: dead_code
              icon: Icon(_expand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          if (_expand)
            Container(
              height: min(widget.order.product.length * 20 + 40, 100),
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: widget.order.product
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${prod.quantity}X   \$ ${prod.price}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
