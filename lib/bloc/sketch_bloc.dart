import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sketchnotes2/bloc/bloc_base.dart';
import 'package:sketchnotes2/logging.dart';
import 'package:sketchnotes2/models/sketch.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/serializers.dart';
import 'package:sketchnotes2/services/file_service.dart';

class SketchBloc extends BlocBase {
  static const FILE_NAME = 'sketch.json';

  final FileService _files;
  StreamSubscription _strokeSubscription;
  final Sink<BuiltList<Stroke>> _strokesSink;
  SketchFile _currentSketch;

  SketchFile get sketchFile => _currentSketch;

  static Future<SketchBloc> build({
    @required FileService fileService,
    @required Observable<BuiltList<Stroke>> strokes,
    @required Sink<BuiltList<Stroke>> strokesSink,
  }) async {
    final bloc = SketchBloc._(fileService, strokesSink);
    await bloc._loadFromFile();
    bloc._init(strokes);
    return bloc;
  }

  SketchBloc._(
    this._files,
    this._strokesSink,
  );

  void _init(Observable<BuiltList<Stroke>> strokesStream) {
    _strokeSubscription = strokesStream.listen((strokes) {
      _currentSketch = SketchFile(
        (b) => b..strokes = strokes.toBuilder(),
      );
      saveToFile();
    });
  }

  Future<void> saveToFile() {
    if (_files != null) {
      return _files.saveToFile(
          fileName: FILE_NAME, text: _currentSketch.toJson());
    } else {
      LOG.e('No FileService available, cannot save file: $FILE_NAME');
      return Future.value(null);
    }
  }

  Future<void> _loadFromFile() async {
    if (_files == null) {
      LOG.e('No FileService available, cannot load file: $FILE_NAME');
      return Future.value(null);
    }
    final loadedData = await _files.loadFromFileAsString(FILE_NAME);
    if (loadedData != null && loadedData.isNotEmpty) {
      final sketch = serializers.deserializeWith<SketchFile>(
          SketchFile.serializer, json.decode(loadedData));
      _strokesSink.add(sketch.strokes);
    } else {
      LOG.e('invalid or missing sketch file data');
    }
  }

  @override
  void dispose() {
    _strokeSubscription?.cancel();
  }
}
