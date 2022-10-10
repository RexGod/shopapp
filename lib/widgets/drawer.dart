import 'package:flutter/material.dart';
import 'package:shopapp/screens/order_screen.dart';
import '../screens/produnt_manager_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 30.0, bottom: 30.0),
              height: 120,
              color: Colors.purple,
              width: double.infinity,
              child: const Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('shop'),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('order'),
              onTap: () {
                Navigator.of(context).pushNamed(Order.routeName);
              },
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('edit'),
              onTap: () {
                Navigator.of(context).pushNamed(ProductMangaerScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
