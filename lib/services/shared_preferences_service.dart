import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchnotes2/logging.dart';
import 'package:sketchnotes2/services/preferences_service.dart';

class SharedPreferencesService implements PreferencesService {
  static const PEN_WIDTH_KEY = 'pen.width';
  static const PEN_COLOR_KEY = 'pen.color';
  final Logger log = Logger('SharedPreferencesService');

  final SharedPreferences _prefs;

  SharedPreferencesService(SharedPreferences prefs) : _prefs = prefs;

  @override
  double get penSize {
    if (_prefs == null) {
      LOG.e('MISSING SHARED PREFS');
    }
    final prefValue = _prefs?.getDouble(PEN_WIDTH_KEY);
    return prefValue ?? 1;
  }

  @override
  Future<bool> savePenSize(double size) async =>
      _prefs.setDouble(PEN_WIDTH_KEY, size);

  @override
  Future<bool> savePenColor(int red, int green, int blue) {
    return _prefs.setString(PEN_COLOR_KEY, '$red,$green,$blue');
  }

  @override
  List<int> get penColor =>
      _prefs
          ?.getString(PEN_COLOR_KEY)
          ?.split(',')
          ?.map((s) => int.parse(s))
          ?.toList() ??
      [0, 0, 0];
}
