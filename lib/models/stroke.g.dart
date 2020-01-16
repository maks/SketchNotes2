// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroke.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Stroke extends Stroke {
  @override
  final BuiltList<TouchLocationEvent> locations;
  @override
  final double strokeWidth;
  @override
  final ColorChangeEvent color;

  factory _$Stroke([void Function(StrokeBuilder) updates]) =>
      (new StrokeBuilder()..update(updates)).build();

  _$Stroke._({this.locations, this.strokeWidth, this.color}) : super._() {
    if (locations == null) {
      throw new BuiltValueNullFieldError('Stroke', 'locations');
    }
    if (strokeWidth == null) {
      throw new BuiltValueNullFieldError('Stroke', 'strokeWidth');
    }
    if (color == null) {
      throw new BuiltValueNullFieldError('Stroke', 'color');
    }
  }

  @override
  Stroke rebuild(void Function(StrokeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StrokeBuilder toBuilder() => new StrokeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Stroke &&
        locations == other.locations &&
        strokeWidth == other.strokeWidth &&
        color == other.color;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, locations.hashCode), strokeWidth.hashCode), color.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Stroke')
          ..add('locations', locations)
          ..add('strokeWidth', strokeWidth)
          ..add('color', color))
        .toString();
  }
}

class StrokeBuilder implements Builder<Stroke, StrokeBuilder> {
  _$Stroke _$v;

  ListBuilder<TouchLocationEvent> _locations;
  ListBuilder<TouchLocationEvent> get locations =>
      _$this._locations ??= new ListBuilder<TouchLocationEvent>();
  set locations(ListBuilder<TouchLocationEvent> locations) =>
      _$this._locations = locations;

  double _strokeWidth;
  double get strokeWidth => _$this._strokeWidth;
  set strokeWidth(double strokeWidth) => _$this._strokeWidth = strokeWidth;

  ColorChangeEventBuilder _color;
  ColorChangeEventBuilder get color =>
      _$this._color ??= new ColorChangeEventBuilder();
  set color(ColorChangeEventBuilder color) => _$this._color = color;

  StrokeBuilder();

  StrokeBuilder get _$this {
    if (_$v != null) {
      _locations = _$v.locations?.toBuilder();
      _strokeWidth = _$v.strokeWidth;
      _color = _$v.color?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Stroke other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Stroke;
  }

  @override
  void update(void Function(StrokeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Stroke build() {
    _$Stroke _$result;
    try {
      _$result = _$v ??
          new _$Stroke._(
              locations: locations.build(),
              strokeWidth: strokeWidth,
              color: color.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'locations';
        locations.build();

        _$failedField = 'color';
        color.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Stroke', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
