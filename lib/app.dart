import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchnotes2/bloc/painter_bloc.dart';
import 'package:sketchnotes2/bloc/sketch_bloc.dart';
import 'package:sketchnotes2/draw_page.dart';
import 'package:sketchnotes2/drawer/drawer.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/services/shared_preferences_service.dart';

class DrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sketchBloc = Provider.of<SketchBloc>(context);
    return MaterialApp(
      title: 'SketchNotes',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SketchNotes'),
        ),
        drawer: Drawer(
          child: DrawerContent(),
        ),
        body: FutureBuilder<PainterBloc>(
            future: _painterBloc(_sketchBloc.strokes, _sketchBloc),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final bloc = snapshot.data;
                return Provider<PainterBloc>(
                  child: DrawPage(),
                  create: (_) => bloc,
                );
              } else {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            }),
      ),
    );
  }

  Future<PainterBloc> _painterBloc(
      Future<BuiltList<Stroke>> strokes, SketchBloc sketchBloc) async {
    final painterBloc = PainterBloc(
      preferences:
          SharedPreferencesService(await SharedPreferences.getInstance()),
      strokes: await strokes,
    );
    sketchBloc.strokesStream = painterBloc.strokes;
    return painterBloc;
  }
}
