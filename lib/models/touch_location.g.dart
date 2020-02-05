// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'touch_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TouchLocationEvent> _$touchLocationEventSerializer =
    new _$TouchLocationEventSerializer();

class _$TouchLocationEventSerializer
    implements StructuredSerializer<TouchLocationEvent> {
  @override
  final Iterable<Type> types = const [TouchLocationEvent, _$TouchLocationEvent];
  @override
  final String wireName = 'TouchLocationEvent';

  @override
  Iterable<Object> serialize(Serializers serializers, TouchLocationEvent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'x',
      serializers.serialize(object.x, specifiedType: const FullType(double)),
      'y',
      serializers.serialize(object.y, specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  TouchLocationEvent deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TouchLocationEventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'x':
          result.x = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'y':
          result.y = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$TouchLocationEvent extends TouchLocationEvent {
  @override
  final double x;
  @override
  final double y;

  factory _$TouchLocationEvent(
          [void Function(TouchLocationEventBuilder) updates]) =>
      (new TouchLocationEventBuilder()..update(updates)).build();

  _$TouchLocationEvent._({this.x, this.y}) : super._() {
    if (x == null) {
      throw new BuiltValueNullFieldError('TouchLocationEvent', 'x');
    }
    if (y == null) {
      throw new BuiltValueNullFieldError('TouchLocationEvent', 'y');
    }
  }

  @override
  TouchLocationEvent rebuild(
          void Function(TouchLocationEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TouchLocationEventBuilder toBuilder() =>
      new TouchLocationEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TouchLocationEvent && x == other.x && y == other.y;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, x.hashCode), y.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TouchLocationEvent')
          ..add('x', x)
          ..add('y', y))
        .toString();
  }
}

class TouchLocationEventBuilder
    implements Builder<TouchLocationEvent, TouchLocationEventBuilder> {
  _$TouchLocationEvent _$v;

  double _x;
  double get x => _$this._x;
  set x(double x) => _$this._x = x;

  double _y;
  double get y => _$this._y;
  set y(double y) => _$this._y = y;

  TouchLocationEventBuilder();

  TouchLocationEventBuilder get _$this {
    if (_$v != null) {
      _x = _$v.x;
      _y = _$v.y;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TouchLocationEvent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TouchLocationEvent;
  }

  @override
  void update(void Function(TouchLocationEventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TouchLocationEvent build() {
    final _$result = _$v ?? new _$TouchLocationEvent._(x: x, y: y);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
