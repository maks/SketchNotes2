import 'dart:async';

abstract class PreferencesService {
  double get penSize;

  Future<bool> savePenSize(double size);
}
