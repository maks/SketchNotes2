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
  static const DEFAULT_SKETCH_NAME = 'sketch';

  // how long we wait to check if another stroke is not incoming
  // so we can for exampel persist strokes
  static const WAIT_FOR_STROKE_COMPLETION = Duration(milliseconds: 500);

  final FileService fileService;
  StreamSubscription _strokeSubscription;
  SketchFile _currentSketch;

  Future<BuiltList<Stroke>> get strokes async {
    if (_currentSketch == null) {
      await _loadFromFile();
    }
    return _currentSketch.strokes;
  }

  String get sketchName => _currentSketch.sketchName;

  SketchBloc(
    this.fileService,
  );

  set strokesStream(Observable<BuiltList<Stroke>> stream) {
    _strokeSubscription =
        stream.debounce(WAIT_FOR_STROKE_COMPLETION).listen((strokes) {
      _currentSketch = SketchFile(
        (b) => b
          ..strokes = strokes.toBuilder()
          ..sketchName = DEFAULT_SKETCH_NAME,
      );
      print('SAVE SKETCH');
      saveToFile();
    });
  }

  /// create new sketchfile and replace current one with it
  Future<void> newFile() async {
    await saveToFile(); // make sure current file saved
    _currentSketch = SketchFile(
      (b) => b..sketchName = DEFAULT_SKETCH_NAME,
    );
  }

  Future<void> saveToFile() {
    if (fileService != null) {
      return fileService.saveToFile(
          fileName: FILE_NAME, text: _currentSketch?.toJson());
    } else {
      LOG.e('No FileService available, cannot save file: $FILE_NAME');
      return Future.value(null);
    }
  }

  Future<void> _loadFromFile() async {
    if (fileService == null) {
      LOG.e('No FileService available, cannot load file: $FILE_NAME');
      return Future.value(null);
    }
    final loadedData = await fileService.loadFromFileAsString(FILE_NAME);
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
