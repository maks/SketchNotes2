import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchnotes2/logging.dart';
import 'package:sketchnotes2/services/preferences_service.dart';

class SharedPreferencesService implements PreferencesService {
  static const PEN_WIDTH_KEY = 'pen.width';
  final Logger log = Logger('SharedPreferencesService');

  final SharedPreferences prefs;

  SharedPreferencesService(this.prefs);

  double get penSize {
    if (prefs == null) {
      LOG.e('MISSING SHARED PREFS');
    }
    final prefValue = prefs?.getDouble(PEN_WIDTH_KEY);
    return prefValue ?? 1;
  }

  Future<bool> savePenSize(double size) async =>
      prefs.setDouble(PEN_WIDTH_KEY, size);
}