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
      }
    }

    return result.build();
  }
}

class _$SketchFile extends SketchFile {
  @override
  final BuiltList<Stroke> strokes;

  factory _$SketchFile([void Function(SketchFileBuilder) updates]) =>
      (new SketchFileBuilder()..update(updates)).build();

  _$SketchFile._({this.strokes}) : super._() {
    if (strokes == null) {
      throw new BuiltValueNullFieldError('SketchFile', 'strokes');
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
    return other is SketchFile && strokes == other.strokes;
  }

  @override
  int get hashCode {
    return $jf($jc(0, strokes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SketchFile')..add('strokes', strokes))
        .toString();
  }
}

class SketchFileBuilder implements Builder<SketchFile, SketchFileBuilder> {
  _$SketchFile _$v;

  ListBuilder<Stroke> _strokes;
  ListBuilder<Stroke> get strokes =>
      _$this._strokes ??= new ListBuilder<Stroke>();
  set strokes(ListBuilder<Stroke> strokes) => _$this._strokes = strokes;

  SketchFileBuilder();

  SketchFileBuilder get _$this {
    if (_$v != null) {
      _strokes = _$v.strokes?.toBuilder();
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
      _$result = _$v ?? new _$SketchFile._(strokes: strokes.build());
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
