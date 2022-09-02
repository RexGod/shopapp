// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import './screens/product_detail_screeen.dart';
import './screens/product_overview_screen.dart';
import './provider/product_provider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            // ignore: deprecated_member_use
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: OverViewScreen(),
       routes: {
        DetailScreen.routeName :(context) => DetailScreen()
       },
      ),
    );
  }
  
}
