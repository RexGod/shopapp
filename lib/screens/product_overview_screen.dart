// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/gridViewbuilder.dart';

// ignore: use_key_in_widget_constructors
class OverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shop'),
      ),
      body: GridViewProduct(),
    );
  }
}
