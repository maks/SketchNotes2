// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ColorChangeEvent extends ColorChangeEvent {
  @override
  final int red;
  @override
  final int green;
  @override
  final int blue;

  factory _$ColorChangeEvent(
          [void Function(ColorChangeEventBuilder) updates]) =>
      (new ColorChangeEventBuilder()..update(updates)).build();

  _$ColorChangeEvent._({this.red, this.green, this.blue}) : super._() {
    if (red == null) {
      throw new BuiltValueNullFieldError('ColorChangeEvent', 'red');
    }
    if (green == null) {
      throw new BuiltValueNullFieldError('ColorChangeEvent', 'green');
    }
    if (blue == null) {
      throw new BuiltValueNullFieldError('ColorChangeEvent', 'blue');
    }
  }

  @override
  ColorChangeEvent rebuild(void Function(ColorChangeEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ColorChangeEventBuilder toBuilder() =>
      new ColorChangeEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ColorChangeEvent &&
        red == other.red &&
        green == other.green &&
        blue == other.blue;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, red.hashCode), green.hashCode), blue.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ColorChangeEvent')
          ..add('red', red)
          ..add('green', green)
          ..add('blue', blue))
        .toString();
  }
}

class ColorChangeEventBuilder
    implements Builder<ColorChangeEvent, ColorChangeEventBuilder> {
  _$ColorChangeEvent _$v;

  int _red;
  int get red => _$this._red;
  set red(int red) => _$this._red = red;

  int _green;
  int get green => _$this._green;
  set green(int green) => _$this._green = green;

  int _blue;
  int get blue => _$this._blue;
  set blue(int blue) => _$this._blue = blue;

  ColorChangeEventBuilder();

  ColorChangeEventBuilder get _$this {
    if (_$v != null) {
      _red = _$v.red;
      _green = _$v.green;
      _blue = _$v.blue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ColorChangeEvent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ColorChangeEvent;
  }

  @override
  void update(void Function(ColorChangeEventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ColorChangeEvent build() {
    final _$result =
        _$v ?? new _$ColorChangeEvent._(red: red, green: green, blue: blue);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
