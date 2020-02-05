import 'dart:async';
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sketchnotes2/bloc/bloc_base.dart';
import 'package:sketchnotes2/logging.dart';
import 'package:sketchnotes2/models/sketch.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/services/file_service.dart';

class SketchBloc extends BlocBase {
  static const FILE_NAME = 'sketch.json';

  final FileService _files;
  StreamSubscription _strokeSubscription;

  SketchBloc({
    @required FileService fileService,
    @required Observable<BuiltList<Stroke>> strokes,
  }) : _files = fileService {
    // final loadedData = await _loadFromFile();
    // if (loadedData != null && loadedData.isNotEmpty) {}
    _strokeSubscription = strokes.listen((strokes) {
      final sketch = SketchFile(
        (b) => b..strokes = strokes.toBuilder(),
      );
      print(sketch.toJson());
      _saveStringToFile(sketch.toJson());
    });
  }

  Future<void> saveToFile(Uint8List bytes) {
    if (_files != null) {
      return _files.saveToFile(fileName: FILE_NAME, bytes: bytes);
    } else {
      LOG.e('No FileService available, cannot save file: $FILE_NAME');
      return Future.value(null);
    }
  }

  Future<void> _saveStringToFile(String text) {
    if (_files != null) {
      return _files.saveToFile(fileName: FILE_NAME, text: text);
    } else {
      LOG.e('No FileService available, cannot save file: $FILE_NAME');
      return Future.value(null);
    }
  }

  Future<String> _loadFromFile() async {
    if (_files != null) {
      return (await _files.loadFromFile(FILE_NAME)).toString();
    } else {
      LOG.e('No FileService available, cannot load file: $FILE_NAME');
      return Future.value(null);
    }
  }

  @override
  void dispose() {
    _strokeSubscription?.cancel();
  }
}
