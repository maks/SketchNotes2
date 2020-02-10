import 'package:flutter/material.dart';
import 'package:sketchnotes2/theme.dart';

AppBar get customAppBar => AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.undo,
                color: APP_COLORS.iconColor,
              ),
              onPressed: null),
          Container(width: DIMENS.margin),
          IconButton(
              icon: Icon(
                Icons.redo,
                color: APP_COLORS.iconColor,
              ),
              onPressed: null),
        ],
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.share,
              color: APP_COLORS.iconColor,
            ),
            onPressed: null),
      ],
    );
