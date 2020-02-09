import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sketchnotes2/bloc/bloc_base.dart';
import 'package:sketchnotes2/logging.dart';
import 'package:sketchnotes2/models/sketch.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/serializers.dart';
import 'package:sketchnotes2/services/file_service.dart';

class SketchBloc extends BlocBase {
  static const FILE_NAME = 'sketch.json';
  // how long we wait to check if another stroke is not incoming
  // so we can for exampel persist strokes
  static const WAIT_FOR_STROKE_COMPLETION = Duration(milliseconds: 500);

  final FileService files;
  StreamSubscription _strokeSubscription;
  SketchFile _currentSketch;

  Future<BuiltList<Stroke>> get strokes async {
    if (_currentSketch == null) {
      await _loadFromFile();
    }
    return _currentSketch.strokes;
  }

  SketchBloc(
    this.files,
  );

  set strokesStream(Observable<BuiltList<Stroke>> stream) {
    _strokeSubscription =
        stream.debounce(WAIT_FOR_STROKE_COMPLETION).listen((strokes) {
      _currentSketch = SketchFile(
        (b) => b..strokes = strokes.toBuilder(),
      );
      print('SAVE SKETCH');
      saveToFile();
    });
  }

  Future<void> saveToFile() {
    if (files != null) {
      return files.saveToFile(
          fileName: FILE_NAME, text: _currentSketch.toJson());
    } else {
      LOG.e('No FileService available, cannot save file: $FILE_NAME');
      return Future.value(null);
    }
  }

  Future<void> _loadFromFile() async {
    if (files == null) {
      LOG.e('No FileService available, cannot load file: $FILE_NAME');
      return Future.value(null);
    }
    final loadedData = await files.loadFromFileAsString(FILE_NAME);
    if (loadedData != null && loadedData.isNotEmpty) {
      _currentSketch = serializers.deserializeWith<SketchFile>(
          SketchFile.serializer, json.decode(loadedData));
    } else {
      _currentSketch = SketchFile(
        (b) => b..strokes = BuiltList<Stroke>(<Stroke>[]).toBuilder(),
      );
      LOG.w('no stored sketch file data - blank sketch created');
    }
  }

  @override
  void dispose() {
    _strokeSubscription?.cancel();
  }
}
