// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sketch.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SketchFile> _$sketchFileSerializer = new _$SketchFileSerializer();

class _$SketchFileSerializer implements StructuredSerializer<SketchFile> {
  @override
  final Iterable<Type> types = const [SketchFile, _$SketchFile];
  @override
  final String wireName = 'SketchFile';

  @override
  Iterable<Object> serialize(Serializers serializers, SketchFile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'strokes',
      serializers.serialize(object.strokes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Stroke)])),
      'sketchName',
      serializers.serialize(object.sketchName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SketchFile deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SketchFileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'strokes':
          result.strokes.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Stroke)]))
              as BuiltList<Stroke>);
          break;
        case 'sketchName':
          result.sketchName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SketchFile extends SketchFile {
  @override
  final BuiltList<Stroke> strokes;
  @override
  final String sketchName;

  factory _$SketchFile([void Function(SketchFileBuilder) updates]) =>
      (new SketchFileBuilder()..update(updates)).build();

  _$SketchFile._({this.strokes, this.sketchName}) : super._() {
    if (strokes == null) {
      throw new BuiltValueNullFieldError('SketchFile', 'strokes');
    }
    if (sketchName == null) {
      throw new BuiltValueNullFieldError('SketchFile', 'sketchName');
    }
  }

  @override
  SketchFile rebuild(void Function(SketchFileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SketchFileBuilder toBuilder() => new SketchFileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SketchFile &&
        strokes == other.strokes &&
        sketchName == other.sketchName;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, strokes.hashCode), sketchName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SketchFile')
          ..add('strokes', strokes)
          ..add('sketchName', sketchName))
        .toString();
  }
}

class SketchFileBuilder implements Builder<SketchFile, SketchFileBuilder> {
  _$SketchFile _$v;

  ListBuilder<Stroke> _strokes;
  ListBuilder<Stroke> get strokes =>
      _$this._strokes ??= new ListBuilder<Stroke>();
  set strokes(ListBuilder<Stroke> strokes) => _$this._strokes = strokes;

  String _sketchName;
  String get sketchName => _$this._sketchName;
  set sketchName(String sketchName) => _$this._sketchName = sketchName;

  SketchFileBuilder();

  SketchFileBuilder get _$this {
    if (_$v != null) {
      _strokes = _$v.strokes?.toBuilder();
      _sketchName = _$v.sketchName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SketchFile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SketchFile;
  }

  @override
  void update(void Function(SketchFileBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SketchFile build() {
    _$SketchFile _$result;
    try {
      _$result = _$v ??
          new _$SketchFile._(strokes: strokes.build(), sketchName: sketchName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'strokes';
        strokes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SketchFile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
