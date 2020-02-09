import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchnotes2/bloc/painter_bloc.dart';
import 'package:sketchnotes2/bloc/sketch_bloc.dart';
import 'package:sketchnotes2/draw_page.dart';
import 'package:sketchnotes2/services/file_service.dart';
import 'package:sketchnotes2/services/shared_preferences_service.dart';

class DrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SketchNotes',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SketchNotes'),
        ),
        body: FutureBuilder<AppServices>(
            future: _getServices(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final services = snapshot.data;
                return Provider<PainterBloc>(
                  child: DrawPage(),
                  create: (_) => PainterBloc(
                    preferences: services.sharedPrefs,
                    strokes: SketchBloc(services.files).strokes,
                  ),
                );
              } else {
                //TODO: need some sort of loading UI
                return Container();
              }
            }),
      ),
    );
  }

  Future<AppServices> _getServices() async {
    final sharedPrefs =
        SharedPreferencesService(await SharedPreferences.getInstance());
    final files = FileService();
    return AppServices(sharedPrefs, files);
  }
}

class AppServices {
  final SharedPreferencesService sharedPrefs;
  final FileService files;

  AppServices(this.sharedPrefs, this.files);
}
