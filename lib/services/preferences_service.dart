import 'dart:async';

abstract class PreferencesService {
  double get penSize;

  Future<bool> savePenSize(double size);

  Future<bool> savePenColor(int red, int green, int blue);
}
