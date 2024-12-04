// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_week.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudyWeek _$StudyWeekFromJson(Map<String, dynamic> json) {
  return _StudyWeek.fromJson(json);
}

/// @nodoc
mixin _$StudyWeek {
  List<bool> get week => throw _privateConstructorUsedError;

  /// Serializes this StudyWeek to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudyWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyWeekCopyWith<StudyWeek> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyWeekCopyWith<$Res> {
  factory $StudyWeekCopyWith(StudyWeek value, $Res Function(StudyWeek) then) =
      _$StudyWeekCopyWithImpl<$Res, StudyWeek>;
  @useResult
  $Res call({List<bool> week});
}

/// @nodoc
class _$StudyWeekCopyWithImpl<$Res, $Val extends StudyWeek>
    implements $StudyWeekCopyWith<$Res> {
  _$StudyWeekCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = null,
  }) {
    return _then(_value.copyWith(
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyWeekImplCopyWith<$Res>
    implements $StudyWeekCopyWith<$Res> {
  factory _$$StudyWeekImplCopyWith(
          _$StudyWeekImpl value, $Res Function(_$StudyWeekImpl) then) =
      __$$StudyWeekImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<bool> week});
}

/// @nodoc
class __$$StudyWeekImplCopyWithImpl<$Res>
    extends _$StudyWeekCopyWithImpl<$Res, _$StudyWeekImpl>
    implements _$$StudyWeekImplCopyWith<$Res> {
  __$$StudyWeekImplCopyWithImpl(
      _$StudyWeekImpl _value, $Res Function(_$StudyWeekImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudyWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = null,
  }) {
    return _then(_$StudyWeekImpl(
      week: null == week
          ? _value._week
          : week // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyWeekImpl extends _StudyWeek {
  const _$StudyWeekImpl({required final List<bool> week})
      : _week = week,
        super._();

  factory _$StudyWeekImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyWeekImplFromJson(json);

  final List<bool> _week;
  @override
  List<bool> get week {
    if (_week is EqualUnmodifiableListView) return _week;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_week);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyWeekImpl &&
            const DeepCollectionEquality().equals(other._week, _week));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_week));

  /// Create a copy of StudyWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyWeekImplCopyWith<_$StudyWeekImpl> get copyWith =>
      __$$StudyWeekImplCopyWithImpl<_$StudyWeekImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyWeekImplToJson(
      this,
    );
  }
}

abstract class _StudyWeek extends StudyWeek {
  const factory _StudyWeek({required final List<bool> week}) = _$StudyWeekImpl;
  const _StudyWeek._() : super._();

  factory _StudyWeek.fromJson(Map<String, dynamic> json) =
      _$StudyWeekImpl.fromJson;

  @override
  List<bool> get week;

  /// Create a copy of StudyWeek
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyWeekImplCopyWith<_$StudyWeekImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
