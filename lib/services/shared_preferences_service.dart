import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchnotes2/services/preferences_service.dart';

class SharedPreferencesService implements PreferencesService {
  static const PEN_WIDTH_KEY = 'pen.width';

  final SharedPreferences prefs;

  SharedPreferencesService(this.prefs);

  double get penSize => prefs.getDouble(PEN_WIDTH_KEY);

  Future<bool> savePenSize(double size) async =>
      prefs.setDouble(PEN_WIDTH_KEY, size);
}
