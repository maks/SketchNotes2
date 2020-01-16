import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchnotes2/bloc/painter_bloc.dart';
import 'package:sketchnotes2/draw_page.dart';
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
        body: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provider<PainterBloc>(
                  child: DrawPage(),
                  create: (_) => PainterBloc(
                    preferences: SharedPreferencesService(snapshot.data),
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
