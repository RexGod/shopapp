// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shopapp/provider/auth.dart';
import 'package:shopapp/provider/cart.dart';
import './screens/product_detail_screeen.dart';
import './screens/product_overview_screen.dart';
import './provider/product_provider.dart';
import 'package:provider/provider.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './provider/order.dart' as ord;
import './screens/produnt_manager_screen.dart';
import './screens/edit_prouct_screen.dart';
import './screens/264 auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => auth()),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(create: ((context) => Cart())),
        ChangeNotifierProvider(
          create: (context) => ord.Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            // ignore: deprecated_member_use
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: AuthScreen(),
        routes: {
          DetailScreen.routeName: (context) => DetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          Order.routeName: (context) => Order(),
          ProductMangaerScreen.routeName: (context) => ProductMangaerScreen(),
          EditScreen.routeName: (context) => EditScreen(),
        },
      ),
    );
  }
}
