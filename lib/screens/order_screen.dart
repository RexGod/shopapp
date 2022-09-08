import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/order.dart' as ord;
import '../widgets/order_items.dart';
import '../widgets/drawer.dart' as d;

class Order extends StatelessWidget {
  static const routeName = '/oreder';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<ord.Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order list'),
      ),
      drawer: d.AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: ((context, index) => OrderItem(orderData.orders[index])),
      ),
    );
  }
}
