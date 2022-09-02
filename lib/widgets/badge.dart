// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Badge({
    required this.child,
    required this.value,
    required this.color,
  });

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // ignore: unnecessary_null_comparison, prefer_if_null_operators
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
