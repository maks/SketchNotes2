import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sketchnotes2/models/stroke.dart';
import 'package:sketchnotes2/serializers.dart';

// Generated code part of this Built Value.
// Generate using `flutter packages pub run build_runner build`
part 'sketch.g.dart';

abstract class SketchFile implements Built<SketchFile, SketchFileBuilder> {
  BuiltList<Stroke> get strokes;

  SketchFile._();

  factory SketchFile([void Function(SketchFileBuilder) updates]) = _$SketchFile;

  String toJson() {
    return json.encode(serializers.serializeWith(SketchFile.serializer, this));
  }

  static SketchFile fromJson(String jsonString) {
    return serializers.deserializeWith(
        SketchFile.serializer, json.decode(jsonString));
  }

  static Serializer<SketchFile> get serializer => _$sketchFileSerializer;
}
