import 'package:built_collection/built_collection.dart';
import 'package:mockito/mockito.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/services/preferences_service.dart';
import 'package:test/test.dart';
import 'package:sketchnotes2/bloc/painter_bloc.dart';
import 'package:sketchnotes2/models/color.dart';
import 'package:sketchnotes2/models/end_touch.dart';
import 'package:sketchnotes2/models/touch_location.dart';
import 'package:sketchnotes2/models/stroke_width.dart';

import 'stroke_maker.dart';

void main() {
  test('initialise PainterBloc with existing list of strokes', () {
    final testStroke1 = makeStroke(5, 6, 7, 7, 10, 20);
    final testStrokes = BuiltList<Stroke>(<Stroke>[testStroke1]);
    final painterBloc = PainterBloc(strokes: testStrokes);

    expect(painterBloc.strokes.value, testStrokes);
  });

  test('Simple stroke', () {
    final painterBloc = PainterBloc();
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 1
        ..y = 2;
    }));
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 5
        ..y = 6;
    }));
    painterBloc.drawEvent.add(EndTouchEvent());
    var callCount = 0;
    painterBloc.strokes.listen(expectAsync1(
      (strokes) {
        callCount++;
        if (callCount > 2) {
          expect(strokes.length, 1);
          final stroke1 = strokes[0];
          expect(stroke1.locations.length, 2);
          expect(stroke1.locations[0].x, 1);
          expect(stroke1.locations[0].y, 2);
          expect(stroke1.locations[1].x, 5);
          expect(stroke1.locations[1].y, 6);
        }
      },
      count: 4,
    ));
  });

  test('Multiple strokes', () {
    final painterBloc = PainterBloc();
    // Stroke 1
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 1
        ..y = 2;
    }));
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 5
        ..y = 6;
    }));
    painterBloc.drawEvent.add(EndTouchEvent());

    // Stroke 2
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 11
        ..y = 12;
    }));
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 15
        ..y = 16;
    }));
    painterBloc.drawEvent.add(EndTouchEvent());

    var callCount = 0;
    painterBloc.strokes.listen(expectAsync1(
      (strokes) {
        callCount++;
        if (callCount > 5) {
          expect(strokes.length, 2);
          final stroke1 = strokes[0];
          final stroke2 = strokes[1];

          expect(stroke1.locations.length, 2);
          expect(stroke1.locations[0].x, 1);
          expect(stroke1.locations[0].y, 2);
          expect(stroke1.locations[1].x, 5);
          expect(stroke1.locations[1].y, 6);

          expect(stroke2.locations.length, 2);
          expect(stroke2.locations[0].x, 11);
          expect(stroke2.locations[0].y, 12);
          expect(stroke2.locations[1].x, 15);
          expect(stroke2.locations[1].y, 16);
        }
      },
      count: 7,
    ));
  });

  test('Color change splits stroke', () {
    final painterBloc = PainterBloc();
    // Stroke 1
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 1
        ..y = 2;
    }));
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 5
        ..y = 6;
    }));
    painterBloc.drawEvent.add(ColorChangeEvent((builder) {
      builder
        ..red = 128
        ..green = 0
        ..blue = 0;
    }));

    // Stroke 2
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 11
        ..y = 12;
    }));
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 15
        ..y = 16;
    }));
    painterBloc.drawEvent.add(EndTouchEvent());

    var callCount = 0;
    painterBloc.strokes.listen(expectAsync1(
      (strokes) {
        callCount++;
        if (callCount > 5) {
          expect(strokes.length, 2);
          final stroke1 = strokes[0];
          final stroke2 = strokes[1];

          expect(stroke1.locations.length, 2);
          expect(stroke1.color, ColorChangeEvent((builder) {
            builder
              ..red = 0
              ..green = 0
              ..blue = 0;
          }));
          expect(stroke1.locations[0].x, 1);
          expect(stroke1.locations[0].y, 2);
          expect(stroke1.locations[1].x, 5);
          expect(stroke1.locations[1].y, 6);

          expect(stroke2.locations.length, 2);
          expect(stroke2.color, ColorChangeEvent((builder) {
            builder
              ..red = 128
              ..green = 0
              ..blue = 0;
          }));
          expect(stroke2.locations[0].x, 11);
          expect(stroke2.locations[0].y, 12);
          expect(stroke2.locations[1].x, 15);
          expect(stroke2.locations[1].y, 16);
        }
      },
      count: 7,
    ));
  });
  test('Stroke Width change splits stroke', () {
    final painterBloc = PainterBloc();
    // Stroke 1
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 1
        ..y = 2;
    }));
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 5
        ..y = 6;
    }));
    painterBloc.drawEvent.add(StrokeWidthChangeEvent((builder) {
      builder.width = 20;
    }));

    // Stroke 2
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 11
        ..y = 12;
    }));
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 15
        ..y = 16;
    }));
    painterBloc.drawEvent.add(EndTouchEvent());

    var callCount = 0;
    painterBloc.strokes.listen(expectAsync1(
      (strokes) {
        callCount++;
        if (callCount > 5) {
          expect(strokes.length, 2);
          final stroke1 = strokes[0];
          final stroke2 = strokes[1];

          expect(stroke1.locations.length, 2);
          expect(stroke1.strokeWidth, 1);
          expect(stroke1.locations[0].x, 1);
          expect(stroke1.locations[0].y, 2);
          expect(stroke1.locations[1].x, 5);
          expect(stroke1.locations[1].y, 6);

          expect(stroke2.locations.length, 2);
          expect(stroke2.strokeWidth, 20);
          expect(stroke2.locations[0].x, 11);
          expect(stroke2.locations[0].y, 12);
          expect(stroke2.locations[1].x, 15);
          expect(stroke2.locations[1].y, 16);
        }
      },
      count: 7,
    ));
  });

  test('persist change in pen size', () async {
    final prefsService = MockPrefsServices();
    final testPenSize = 20.0;
    when(prefsService.savePenSize(any)).thenAnswer((_) async => true);

    final painterBloc = PainterBloc(preferences: prefsService);
    painterBloc.drawEvent.add(StrokeWidthChangeEvent((builder) {
      builder.width = testPenSize;
    }));

    await untilCalled(prefsService.savePenSize(any));
    verify(prefsService.savePenSize(testPenSize)).called(1);
  });

  test('initialise pen size from persisted value', () {
    final prefsService = MockPrefsServices();
    final testPenSize = 42.0;
    when(prefsService.penSize).thenReturn(testPenSize);

    final painterBloc = PainterBloc(preferences: prefsService);

    painterBloc.width.listen(
      expectAsync1((width) {
        expect(width, testPenSize);
      }),
    );
    verify(prefsService.penSize).called(1);
  });

  test('persist change in pen color', () async {
    final prefsService = MockPrefsServices();
    final testPenColorChange = ColorChangeEvent((builder) {
      builder
        ..red = 128
        ..green = 0
        ..blue = 64;
    });
    when(prefsService.savePenColor(any, any, any))
        .thenAnswer((_) async => true);

    final painterBloc = PainterBloc(preferences: prefsService);
    painterBloc.drawEvent.add(testPenColorChange);

    await untilCalled(prefsService.savePenColor(any, any, any));
    verify(prefsService.savePenColor(128, 0, 64)).called(1);
  });

  test('initialise pen color from persisted value', () {
    final prefsService = MockPrefsServices();
    final testPenColor = [0, 10, 50];
    when(prefsService.penColor).thenReturn(testPenColor);

    final painterBloc = PainterBloc(preferences: prefsService);

    painterBloc.color.listen(
      expectAsync1((color) {
        expect(color.red, testPenColor[0]);
        expect(color.green, testPenColor[1]);
        expect(color.blue, testPenColor[2]);
      }),
    );
    verify(prefsService.penColor).called(1);
  });

  test('new stroke uses pen color from persisted value', () {
    final prefsService = MockPrefsServices();
    final testPenColor = [0, 10, 50];
    final testPenColorEvent = (ColorChangeEventBuilder()
          ..red = testPenColor[0]
          ..green = testPenColor[1]
          ..blue = testPenColor[2])
        .build();
    when(prefsService.penColor).thenReturn(testPenColor);
    when(prefsService.penSize).thenReturn(1.0);

    final painterBloc = PainterBloc(preferences: prefsService);

    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 123
        ..y = 321;
    }));
    painterBloc.drawEvent.add(EndTouchEvent());

    painterBloc.strokes.listen(
      expectAsync1((strokes) {
        if (strokes.isNotEmpty) {
          expect(strokes.first.color, testPenColorEvent);
        }
      }, count: 3),
    );
  });

  test('new stroke uses pen size from persisted value', () {
    final prefsService = MockPrefsServices();
    final testPenSize = 42.0;
    when(prefsService.penSize).thenReturn(testPenSize);

    final painterBloc = PainterBloc(preferences: prefsService);
    painterBloc.drawEvent.add(TouchLocationEvent((builder) {
      builder
        ..x = 123
        ..y = 321;
    }));
    painterBloc.drawEvent.add(EndTouchEvent());

    painterBloc.strokes.listen(
      expectAsync1((strokes) {
        if (strokes.isNotEmpty) {
          expect(strokes.first.strokeWidth, testPenSize);
        }
      }, count: 3),
    );
  });
}

class MockPrefsServices extends Mock implements PreferencesService {}
