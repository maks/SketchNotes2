import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import './draw_event.dart';

// Generated code part of this Built Value.
// Generate using `flutter packages pub run build_runner build`
part 'stroke_width.g.dart';

abstract class StrokeWidthChangeEvent
    implements
        Built<StrokeWidthChangeEvent, StrokeWidthChangeEventBuilder>,
        DrawEvent {
  double get width;

  static Serializer<StrokeWidthChangeEvent> get serializer =>
      _$strokeWidthChangeEventSerializer;

  StrokeWidthChangeEvent._();
  factory StrokeWidthChangeEvent(
          [void Function(StrokeWidthChangeEventBuilder) updates]) =
      _$StrokeWidthChangeEvent;
}
