import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopapp/screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('shop'),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('order'),
              onTap: () {
                Navigator.of(context).pushNamed(Order.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
