// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grading_system.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GradingSystem _$GradingSystemFromJson(Map<String, dynamic> json) {
  return _GradingScale.fromJson(json);
}

/// @nodoc
mixin _$GradingSystem {
  GradingScale get scale => throw _privateConstructorUsedError;

  /// Serializes this GradingSystem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GradingSystem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GradingSystemCopyWith<GradingSystem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GradingSystemCopyWith<$Res> {
  factory $GradingSystemCopyWith(
          GradingSystem value, $Res Function(GradingSystem) then) =
      _$GradingSystemCopyWithImpl<$Res, GradingSystem>;
  @useResult
  $Res call({GradingScale scale});
}

/// @nodoc
class _$GradingSystemCopyWithImpl<$Res, $Val extends GradingSystem>
    implements $GradingSystemCopyWith<$Res> {
  _$GradingSystemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GradingSystem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
  }) {
    return _then(_value.copyWith(
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as GradingScale,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GradingScaleImplCopyWith<$Res>
    implements $GradingSystemCopyWith<$Res> {
  factory _$$GradingScaleImplCopyWith(
          _$GradingScaleImpl value, $Res Function(_$GradingScaleImpl) then) =
      __$$GradingScaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GradingScale scale});
}

/// @nodoc
class __$$GradingScaleImplCopyWithImpl<$Res>
    extends _$GradingSystemCopyWithImpl<$Res, _$GradingScaleImpl>
    implements _$$GradingScaleImplCopyWith<$Res> {
  __$$GradingScaleImplCopyWithImpl(
      _$GradingScaleImpl _value, $Res Function(_$GradingScaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of GradingSystem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
  }) {
    return _then(_$GradingScaleImpl(
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as GradingScale,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GradingScaleImpl extends _GradingScale {
  const _$GradingScaleImpl({required this.scale}) : super._();

  factory _$GradingScaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$GradingScaleImplFromJson(json);

  @override
  final GradingScale scale;

  @override
  String toString() {
    return 'GradingSystem(scale: $scale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradingScaleImpl &&
            (identical(other.scale, scale) || other.scale == scale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, scale);

  /// Create a copy of GradingSystem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GradingScaleImplCopyWith<_$GradingScaleImpl> get copyWith =>
      __$$GradingScaleImplCopyWithImpl<_$GradingScaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GradingScaleImplToJson(
      this,
    );
  }
}

abstract class _GradingScale extends GradingSystem {
  const factory _GradingScale({required final GradingScale scale}) =
      _$GradingScaleImpl;
  const _GradingScale._() : super._();

  factory _GradingScale.fromJson(Map<String, dynamic> json) =
      _$GradingScaleImpl.fromJson;

  @override
  GradingScale get scale;

  /// Create a copy of GradingSystem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GradingScaleImplCopyWith<_$GradingScaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
