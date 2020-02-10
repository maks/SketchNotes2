import 'package:flutter/material.dart';

class DrawerTopbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: null),
        IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: null),
      ],
    );
  }
}
