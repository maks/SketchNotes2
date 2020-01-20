import 'dart:async';

abstract class PreferencesService {
  double get penSize;

  /// returns color as a List: [red,green,blue]
  List<int> get penColor;

  Future<bool> savePenSize(double size);

  Future<bool> savePenColor(int red, int green, int blue);
}
