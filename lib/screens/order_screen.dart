import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/order.dart' as ord;
import '../widgets/order_items.dart';
import '../widgets/drawer.dart' as d;

class Order extends StatefulWidget {
  static const routeName = '/oreder';

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ord.Order>(context, listen: false)
          .fetchAndStoreOrders()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<ord.Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order list'),
      ),
      drawer: d.AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: ((context, index) =>
                  OrderItem(orderData.orders[index])),
            ),
    );
  }
}
