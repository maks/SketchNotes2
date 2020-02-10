import 'package:flutter/material.dart';
import 'package:sketchnotes2/theme.dart';

class DrawerTopbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.settings,
              color: APP_COLORS.drawerIconColor,
            ),
            onPressed: null),
        IconButton(
            icon: Icon(
              Icons.add,
              color: APP_COLORS.drawerIconColor,
            ),
            onPressed: null),
      ],
    );
  }
}
