import 'package:mockito/mockito.dart';
import 'package:sketchnotes2/services/preferences_service.dart';
import 'package:test/test.dart';
import 'package:sketchnotes2/bloc/painter_bloc.dart';
import 'package:sketchnotes2/models/color.dart';
import 'package:sketchnotes2/models/end_touch.dart';
import 'package:sketchnotes2/models/touch_location.dart';
import 'package:sketchnotes2/models/stroke_width.dart';

void main() {
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
}

class MockPrefsServices extends Mock implements PreferencesService {}
