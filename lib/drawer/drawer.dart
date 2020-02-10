import 'package:flutter/material.dart';
import 'package:sketchnotes2/drawer/drawer_topbar.dart';
import 'package:sketchnotes2/theme.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(DIMENS.margin),
            decoration: BoxDecoration(
              color: APP_COLORS.drawerHeaderColor,
            ),
            child: SafeArea(
              child: DrawerTopbar(),
            )),
      ],
    );
  }
}