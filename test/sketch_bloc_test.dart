import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:mockito/mockito.dart';
import 'package:quiver/testing/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sketchnotes2/bloc/sketch_bloc.dart';
import 'package:sketchnotes2/models/sketch.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/serializers.dart';
import 'package:sketchnotes2/services/file_service.dart';
import 'package:test/test.dart';
import 'stroke_maker.dart';

void main() {
  setUp(() {
    // need this due to bug:
    // https://github.com/flutter/flutter/issues/20907#issuecomment-568527985
    if (Directory.current.path.endsWith('/test')) {
      Directory.current = Directory.current.parent;
    }
  });

  group('sketch serialisation', () {
    test('read persisted file when sketchbloc created', () async {
      final mockFileService = MockFileService();

      when(mockFileService.loadFromFileAsString(any))
          .thenAnswer((_) => Future.value(''));

      final testBloc = await SketchBloc(mockFileService);

      expect(testBloc, isA<SketchBloc>());
    });

    test('sketch bloc caches added strokes', () async {
      FakeAsync().run((async) {
        final mockFileService = MockFileService();
        final strokesSubject = BehaviorSubject<BuiltList<Stroke>>();

        when(mockFileService.loadFromFileAsString(any))
            .thenAnswer((_) => Future.value(''));

        final testBloc = SketchBloc(mockFileService);

        testBloc.strokesStream = strokesSubject;

        final stroke1 = makeStroke(5, 10, 20, 90, 25, 35);
        final strokes = (BuiltList<Stroke>().toBuilder()..add(stroke1)).build();

        strokesSubject.sink.add(strokes);

        // fastforward time for debounce duration to elapse
        async.elapse(SketchBloc.WAIT_FOR_STROKE_COMPLETION);

        // need to wait as SketchBloc's only give out Futures of Stroke Lists
        BuiltList<Stroke> futureStrokes;
        testBloc.strokes.then((x) => futureStrokes = x);
        // now need to flush to get Future resolved
        async.flushMicrotasks();

        expect(futureStrokes, strokes);
      });
    });

    test('persist strokes', () async {
      FakeAsync().run((async) {
        final strokesSubject = BehaviorSubject<BuiltList<Stroke>>();
        final mockFileService = MockFileService();
        when(mockFileService.loadFromFileAsString(any))
            .thenAnswer((_) => Future.value(''));

        final testBloc = SketchBloc(mockFileService);
        testBloc.strokesStream = strokesSubject;

        final stroke1 = makeStroke(5, 10, 20, 90, 25, 35);
        final strokes = (BuiltList<Stroke>().toBuilder()..add(stroke1)).build();

        strokesSubject.sink.add(strokes);

        // fastforward time for debounce duration to elapse
        async.elapse(SketchBloc.WAIT_FOR_STROKE_COMPLETION);

        testBloc.saveToFile();

        final json = r'''
    {"strokes":[{"locations":[{"x":25.0,"y":35.0}],"strokeWidth":5.0,"color":{"red":0,"green":0,"blue":0}}]}
    ''';
        final jsonPersisted = verify(mockFileService.saveToFile(
          bytes: anyNamed('bytes'),
          fileName: 'sketch.json',
          text: captureAnyNamed('text'),
        )).captured.first.toString();
        expect(collapseWhitespace(jsonPersisted), collapseWhitespace(json));
      });
    });

    test('valid strokes serialisation', () async {
      final sketchFile = File('test_resources/sketch.json');

      final sketch = serializers.deserializeWith<SketchFile>(
          SketchFile.serializer, json.decode(sketchFile.readAsStringSync()));

      expect(sketch.strokes.length, 1);
      expect(sketch.strokes[0].locations.length, 4);
      expect(sketch.strokes[0].locations[0].x, 215.23809523809524);
      expect(sketch.strokes[0].locations[0].y, 225.90476190476193);
    });
  });
}

class MockFileService extends Mock implements FileService {}
