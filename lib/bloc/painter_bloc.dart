import 'dart:async';
import 'dart:typed_data';
import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sketchnotes2/logging.dart';
import 'package:sketchnotes2/services/file_service.dart';
import 'package:sketchnotes2/services/preferences_service.dart';
import 'package:sketchnotes2/models/clear.dart';
import 'package:sketchnotes2/models/color.dart';
import 'package:sketchnotes2/models/draw_event.dart';
import 'package:sketchnotes2/models/end_touch.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/models/stroke_width.dart';
import 'package:sketchnotes2/models/touch_location.dart';
import 'bloc_base.dart';

class PainterBloc extends BlocBase {
  static const FILE_NAME = 'sketch.png';

  final PreferencesService _preferences;
  final FileService _files;

  // Completed strokes
  BuiltList<Stroke> _strokes = BuiltList<Stroke>();

  // In progress stroke
  BuiltList<TouchLocationEvent> _locations = BuiltList<TouchLocationEvent>();
  ColorChangeEvent _color = (ColorChangeEventBuilder()
        ..red = 0
        ..green = 0
        ..blue = 0)
      .build();
  double _width = 1;

  // Streamed input into this BLoC
  final _drawEvents = BehaviorSubject<DrawEvent>();
  StreamSink<DrawEvent> get drawEvent => _drawEvents.sink;

  // Streamed outputs from this BLoC
  final _strokesSubject = BehaviorSubject<BuiltList<Stroke>>();
  StreamSink<BuiltList<Stroke>> get _strokesOut => _strokesSubject.sink;
  ValueObservable<BuiltList<Stroke>> get strokes => _strokesSubject.stream;

  final _colorSubject = BehaviorSubject<ColorChangeEvent>();
  StreamSink<ColorChangeEvent> get _colorOut => _colorSubject.sink;
  ValueObservable<ColorChangeEvent> get color => _colorSubject.stream;

  final _widthSubject = BehaviorSubject<double>();
  StreamSink<double> get _widthOut => _widthSubject.sink;
  ValueObservable<double> get width => _widthSubject.stream;

  PainterBloc({PreferencesService preferences, FileService fileService})
      : _preferences = preferences,
        _files = fileService {
    // Publish initial state
    _strokesOut.add(_strokes);

    if (preferences != null) {
      _initFromPreferences();
    } else {
      LOG.e('No PreferencesService available, cannot load previous settings');
      _widthOut.add(_width);
      _colorOut.add(_color);
    }

    // Update state based on events
    _drawEvents.stream.listen((drawEvent) {
      if (drawEvent is ClearEvent) {
        _strokes = BuiltList<Stroke>();
        _locations = BuiltList<TouchLocationEvent>();
        _strokesOut.add(_strokes);
      } else if (drawEvent is ColorChangeEvent) {
        finalizeCurrentStroke();
        _color = drawEvent;
        _colorOut.add(_color);
        if (_preferences != null) {
          _preferences.savePenColor(_color.red, _color.green, _color.blue);
        } else {
          LOG.e('No PreferencesService available, cannot save color setting');
        }
      } else if (drawEvent is TouchLocationEvent) {
        _locations = (_locations.toBuilder()..add(drawEvent)).build();
        final allStrokes = (_strokes.toBuilder()..add(_stroke)).build();
        _strokesOut.add(allStrokes);
      } else if (drawEvent is EndTouchEvent) {
        finalizeCurrentStroke();
      } else if (drawEvent is StrokeWidthChangeEvent) {
        finalizeCurrentStroke();
        _width = drawEvent.width;
        _widthOut.add(_width);
        if (_preferences != null) {
          _preferences.savePenSize(_width);
        } else {
          LOG.e('No PreferencesService available, cannot save width setting');
        }
      } else {
        throw UnimplementedError('Unknown DrawEvent type: $drawEvent');
      }
    });
  }

  Stroke get _stroke => Stroke(
        (strokeBuilder) {
          strokeBuilder
            ..strokeWidth = _width
            ..color = _color.toBuilder()
            ..locations = _locations.toBuilder();
        },
      );

  void finalizeCurrentStroke() {
    if (_locations.isNotEmpty) {
      _strokes = (_strokes.toBuilder()..add(_stroke)).build();
      _strokesOut.add(_strokes);
      _locations = BuiltList<TouchLocationEvent>();
    }
  }

  Future<void> saveToFile(Uint8List pngBytes) {
    if (_files != null) {
      return _files.saveToFile(FILE_NAME, pngBytes);
    } else {
      LOG.e('No FileService available, cannot save file: $FILE_NAME');
      return Future.value(null);
    }
  }

  void _initFromPreferences() {
    _width = _preferences.penSize;
    _widthOut.add(_width);
    final penColor = _preferences.penColor;
    if (penColor != null) {
      _color = (ColorChangeEventBuilder()
            ..red = penColor[0]
            ..green = penColor[1]
            ..blue = penColor[2])
          .build();
      _colorOut.add(_color);
    }
  }

  @override
  void dispose() {
    _drawEvents.close();
    _strokesSubject.close();
    _colorSubject.close();
    _strokesSubject.close();
  }
}
