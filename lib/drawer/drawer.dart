import 'package:flutter/material.dart';
import 'drawer_topbar.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: SafeArea(
              child: DrawerTopbar(),
            )),
      ],
    );
  }
}
