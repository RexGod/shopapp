import 'package:flutter/material.dart';
import '../provider/order.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItems order;
  OrderItem(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime)),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.expand_more)),
          ),
        ],
      ),
    );
  }
}
