import 'package:built_collection/built_collection.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sketchnotes2/bloc/sketch_bloc.dart';
import 'package:sketchnotes2/models/color.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/models/touch_location.dart';
import 'package:sketchnotes2/services/file_service.dart';
import 'package:test/test.dart';

void main() {
  test('persist strokes', () async {
    final strokesSubject = BehaviorSubject<BuiltList<Stroke>>();
    final mockFileService = MockFileService();
    SketchBloc(strokes: strokesSubject, fileService: mockFileService);
    final stroke1 = _makeStroke(5, 10, 20, 90, 25, 35);
    final strokes = (BuiltList<Stroke>().toBuilder()..add(stroke1)).build();

    strokesSubject.sink.add(strokes);

    await untilCalled(mockFileService.saveToFile(
      bytes: anyNamed('bytes'),
      fileName: anyNamed('fileName'),
      text: anyNamed('text'),
    ));
    verify(
      mockFileService.saveToFile(
        bytes: anyNamed('bytes'),
        fileName: 'sketch.json',
        text: anyNamed('text'),
      ),
    );
  });
}

Stroke _makeStroke(
    double width, int red, int green, int blue, double dx, double dy) {
  final ColorChangeEvent color = (ColorChangeEventBuilder()
        ..red = 0
        ..green = 0
        ..blue = 0)
      .build();
  final drawEvent = TouchLocationEvent((builder) {
    builder
      ..x = dx
      ..y = dy;
  });
  BuiltList<TouchLocationEvent> locations = BuiltList<TouchLocationEvent>();
  locations = (locations.toBuilder()..add(drawEvent)).build();

  return Stroke(
    (strokeBuilder) {
      strokeBuilder
        ..strokeWidth = width
        ..color = color.toBuilder()
        ..locations = locations.toBuilder();
    },
  );
}

class MockFileService extends Mock implements FileService {}
