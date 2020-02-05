import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileService {
  Future<Directory> get _storageDirectory => getApplicationDocumentsDirectory();

  Future<void> saveToFile(
      {String fileName, Uint8List bytes, String text}) async {
    final directory = await _storageDirectory;
    final path = p.join(directory.path, fileName);
    final output = File(path);
    if (text != null) {
      await output.writeAsString(text);
    } else if (bytes != null) {
      await output.writeAsBytes(bytes);
    }
    print('wrote to file: $path');
  }

  Future<Uint8List> loadFromFile(String fileName) async {
    final directory = await _storageDirectory;
    final path = p.join(directory.path, fileName);
    final input = File(path);
    final bytes = await input.readAsBytes();
    print('read from file: $path');
    return bytes;
  }
}
