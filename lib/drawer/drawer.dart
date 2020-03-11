import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketchnotes2/bloc/sketch_bloc.dart';
import 'package:sketchnotes2/drawer/drawer_topbar.dart';
import 'package:sketchnotes2/theme.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sb = Provider.of<SketchBloc>(context);
    print('show files');

    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(DIMENS.margin),
            decoration: BoxDecoration(
              color: APP_COLORS.drawerHeaderColor,
            ),
            child: SafeArea(
              child: DrawerTopbar(),
            )),
        FutureBuilder<List<File>>(
          future: sb.listSketches(),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Image.file(snapshot.data[index]);
                  },
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
