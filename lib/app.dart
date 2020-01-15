import 'package:provider/provider.dart';
import 'package:sketchnotes2/draw_page.dart';
import 'package:sketchnotes2/bloc/painter_bloc.dart';
import 'package:flutter/material.dart';

class DrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SketchNotes',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SketchNotes'),
        ),
        body: Provider<PainterBloc>(
          child: DrawPage(),
          create: (_) => PainterBloc(),
        ),
      ),
    );
  }
}
