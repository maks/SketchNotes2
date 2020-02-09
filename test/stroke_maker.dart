import 'package:built_collection/built_collection.dart';
import 'package:sketchnotes2/models/color.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/models/touch_location.dart';

Stroke makeStroke(
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
