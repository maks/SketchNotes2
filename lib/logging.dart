import 'dart:io';

import 'package:logger/logger.dart';

Logger get LOG => Logger(printer: SimpleLogPrinter());

class SimpleLogPrinter extends LogPrinter {
  // no ansi color for iOS :-(
  // see: https://github.com/flutter/flutter/issues/20663
  final useColor = Platform.isAndroid;

  @override
  List<String> log(LogEvent event) {
    final dynamic color = PrettyPrinter.levelColors[event.level];
    final dynamic emoji = PrettyPrinter.levelEmojis[event.level];
    final String className = _getClassName(StackTrace.current);
    final now = DateTime.now();
    final String timestamp =
        '${now.day}/${now.month.toString().padLeft(2, '0')} ${now.hour}:${now.minute}:${now.millisecond}.${now.microsecond}';
    var text = '$emoji [$timestamp] ($className) ${event.message}';

    if (event.error != null) {
      text += '${event.error}\n${event.stackTrace ?? StackTrace.current}';
    }

    text = useColor ? color(text).toString() : text;
    return [text];
  }

  /// DEPENDS on current format of Dart stack trace string format,
  /// this method will BREAK if it ever changes
  String _getClassName(StackTrace s) {
    final lines = s.toString().split('\n');
    final v = lines[3].split(' ')..removeWhere((item) => item == '');
    return v[1];
  }
}
