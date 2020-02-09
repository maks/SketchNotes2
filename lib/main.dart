import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketchnotes2/app.dart';
import 'package:sketchnotes2/bloc/sketch_bloc.dart';
import 'package:sketchnotes2/error_reporting.dart';
import 'package:sketchnotes2/services/file_service.dart';

void main() {
// This captures errors reported by the Flutter framework.
  FlutterError.onError = flutterOnErrorHandler;

  // This creates a [Zone] that contains the Flutter application and establishes
  // an error handler that captures errors.
  //
  // Using a zone makes sure that as many errors as possible are captured,
  // including those thrown from [Timer]s, microtasks, I/O, and those forwarded
  // from the `FlutterError` handler above.
  runZoned<Future<void>>(() async {
    // Need to init native here, as setPreferredOrientations uses native channel
    WidgetsFlutterBinding.ensureInitialized();

    runApp(Provider<SketchBloc>(
      create: (_) => SketchBloc(FileService()),
      child: DrawApp(),
    ));
  }, onError: (Object error, StackTrace stackTrace) {
    // Whenever an error occurs, call the `reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    reportError(error, stackTrace);
  });
}
