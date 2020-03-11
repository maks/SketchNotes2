import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sketchnotes2/logging.dart';

class FileService {
  Future<Directory> get _dataDirectory => getApplicationDocumentsDirectory();
  Directory get _storageDirectory =>
      Directory('/data/data/com.manichord.sketchnotes/files');

  Future<void> saveToDataFile(
      {String fileName, Uint8List bytes, String text}) async {
    final directory = await _dataDirectory;
    print('DATA IS: $directory');
    final path = p.join(directory.path, fileName);
    final output = File(path);
    if (text != null) {
      await output.writeAsString(text);
    } else if (bytes != null) {
      await output.writeAsBytes(bytes);
    }
    LOG.d('wrote to file: $path');
  }

  Future<Uint8List> loadFromFile(String fileName) async {
    final input = await _file(fileName);
    final bytes = await input.readAsBytes();
    LOG.d('read data from file: ${input.path}');
    return bytes;
  }

  Future<String> loadFromFileAsString(String fileName) async {
    final input = await _file(fileName);
    final bytes = await input.readAsString();
    LOG.d('read string from file: ${input.path}');
    return bytes;
  }

  Future<List<String>> listStorage() async {
    final files = _storageDirectory.list();
    return files.map((f) {
      print('FILE: $f');
      return f.path;
    }).toList();
  }

  Future<File> _file(String fileName) async {
    final directory = await _dataDirectory;
    print('DATA IS: $directory');
    final path = p.join(directory.path, fileName);
    return File(path);
  }
}
