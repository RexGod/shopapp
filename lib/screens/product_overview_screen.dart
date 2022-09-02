// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../widgets/gridViewbuilder.dart';

enum SelectedValueFilterOption { all, favorites }

// ignore: use_key_in_widget_constructors
class OverViewScreen extends StatefulWidget {
  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  var _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shop'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: SelectedValueFilterOption.favorites,
                      child: Text('Only Favorites'),
                    ),
                    PopupMenuItem(
                        value: SelectedValueFilterOption.all,
                        child: Text('Show All'))
                  ],
              onSelected: (SelectedValueFilterOption value) {
                setState(() {
                  if (value == SelectedValueFilterOption.favorites) {
                    _isFavorite = true;
                  } else {
                    _isFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: GridViewProduct(_isFavorite),
    );
  }
}
