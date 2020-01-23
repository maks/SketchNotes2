import 'dart:async';
import 'dart:typed_data';

import 'package:sketchnotes2/logging.dart';
import 'package:sketchnotes2/services/file_service.dart';

class SketchBloc {
  static const FILE_NAME = 'sketch.png';

  final FileService _files;

  SketchBloc({FileService fileService}) : _files = fileService;

  Future<void> saveToFile(Uint8List pngBytes) {
    if (_files != null) {
      return _files.saveToFile(FILE_NAME, pngBytes);
    } else {
      LOG.e('No FileService available, cannot save file: $FILE_NAME');
      return Future.value(null);
    }
  }
}
