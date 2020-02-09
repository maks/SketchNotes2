// Once per app, define a top level "Serializer" to gather together
// all the generated serializers.
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:sketchnotes2/models/color.dart';
import 'package:sketchnotes2/models/sketch.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/models/stroke_width.dart';
import 'package:sketchnotes2/models/touch_location.dart';

part 'serializers.g.dart';

@SerializersFor([
  Stroke,
  ColorChangeEvent,
  StrokeWidthChangeEvent,
  TouchLocationEvent,
  SketchFile,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..addBuilderFactory(
          FullType(BuiltList, [FullType(Stroke)]), () => ListBuilder<Stroke>()))
    .build();

// T deserialize<T>(dynamic value) => serializers.deserializeWith<T>(
//     serializers.serializerForType(T) as Serializer<T>, value);

// BuiltList<T> deserializeListOf<T>(Iterable value) => BuiltList.from(value
//     .map((dynamic value) => deserialize<T>(value))
//     .toList(growable: false));
