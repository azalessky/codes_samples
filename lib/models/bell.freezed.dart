// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bell.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Bell _$BellFromJson(Map<String, dynamic> json) {
  return _Bell.fromJson(json);
}

/// @nodoc
mixin _$Bell {
  String get id => throw _privateConstructorUsedError;
  @TimeOfDayConverter()
  TimeOfDay get start => throw _privateConstructorUsedError;
  @TimeOfDayConverter()
  TimeOfDay get end => throw _privateConstructorUsedError;

  /// Serializes this Bell to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bell
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BellCopyWith<Bell> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BellCopyWith<$Res> {
  factory $BellCopyWith(Bell value, $Res Function(Bell) then) =
      _$BellCopyWithImpl<$Res, Bell>;
  @useResult
  $Res call(
      {String id,
      @TimeOfDayConverter() TimeOfDay start,
      @TimeOfDayConverter() TimeOfDay end});
}

/// @nodoc
class _$BellCopyWithImpl<$Res, $Val extends Bell>
    implements $BellCopyWith<$Res> {
  _$BellCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bell
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BellImplCopyWith<$Res> implements $BellCopyWith<$Res> {
  factory _$$BellImplCopyWith(
          _$BellImpl value, $Res Function(_$BellImpl) then) =
      __$$BellImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @TimeOfDayConverter() TimeOfDay start,
      @TimeOfDayConverter() TimeOfDay end});
}

/// @nodoc
class __$$BellImplCopyWithImpl<$Res>
    extends _$BellCopyWithImpl<$Res, _$BellImpl>
    implements _$$BellImplCopyWith<$Res> {
  __$$BellImplCopyWithImpl(_$BellImpl _value, $Res Function(_$BellImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bell
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$BellImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BellImpl implements _Bell {
  const _$BellImpl(
      {required this.id,
      @TimeOfDayConverter() required this.start,
      @TimeOfDayConverter() required this.end});

  factory _$BellImpl.fromJson(Map<String, dynamic> json) =>
      _$$BellImplFromJson(json);

  @override
  final String id;
  @override
  @TimeOfDayConverter()
  final TimeOfDay start;
  @override
  @TimeOfDayConverter()
  final TimeOfDay end;

  @override
  String toString() {
    return 'Bell(id: $id, start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BellImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, start, end);

  /// Create a copy of Bell
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BellImplCopyWith<_$BellImpl> get copyWith =>
      __$$BellImplCopyWithImpl<_$BellImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BellImplToJson(
      this,
    );
  }
}

abstract class _Bell implements Bell {
  const factory _Bell(
      {required final String id,
      @TimeOfDayConverter() required final TimeOfDay start,
      @TimeOfDayConverter() required final TimeOfDay end}) = _$BellImpl;

  factory _Bell.fromJson(Map<String, dynamic> json) = _$BellImpl.fromJson;

  @override
  String get id;
  @override
  @TimeOfDayConverter()
  TimeOfDay get start;
  @override
  @TimeOfDayConverter()
  TimeOfDay get end;

  /// Create a copy of Bell
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BellImplCopyWith<_$BellImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
