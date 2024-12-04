// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  String get id => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get colorTheme => throw _privateConstructorUsedError;
  String get backgroundImage => throw _privateConstructorUsedError;
  StudyWeek get studyWeek => throw _privateConstructorUsedError;
  GradingSystem get gradingSystem => throw _privateConstructorUsedError;
  int get periodCount => throw _privateConstructorUsedError;
  RepeatSchedule get repeatSchedule => throw _privateConstructorUsedError;

  /// Serializes this Config to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call(
      {String id,
      ThemeMode themeMode,
      @ColorConverter() Color colorTheme,
      String backgroundImage,
      StudyWeek studyWeek,
      GradingSystem gradingSystem,
      int periodCount,
      RepeatSchedule repeatSchedule});

  $StudyWeekCopyWith<$Res> get studyWeek;
  $GradingSystemCopyWith<$Res> get gradingSystem;
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? themeMode = null,
    Object? colorTheme = null,
    Object? backgroundImage = null,
    Object? studyWeek = null,
    Object? gradingSystem = null,
    Object? periodCount = null,
    Object? repeatSchedule = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      colorTheme: null == colorTheme
          ? _value.colorTheme
          : colorTheme // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundImage: null == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String,
      studyWeek: null == studyWeek
          ? _value.studyWeek
          : studyWeek // ignore: cast_nullable_to_non_nullable
              as StudyWeek,
      gradingSystem: null == gradingSystem
          ? _value.gradingSystem
          : gradingSystem // ignore: cast_nullable_to_non_nullable
              as GradingSystem,
      periodCount: null == periodCount
          ? _value.periodCount
          : periodCount // ignore: cast_nullable_to_non_nullable
              as int,
      repeatSchedule: null == repeatSchedule
          ? _value.repeatSchedule
          : repeatSchedule // ignore: cast_nullable_to_non_nullable
              as RepeatSchedule,
    ) as $Val);
  }

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudyWeekCopyWith<$Res> get studyWeek {
    return $StudyWeekCopyWith<$Res>(_value.studyWeek, (value) {
      return _then(_value.copyWith(studyWeek: value) as $Val);
    });
  }

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GradingSystemCopyWith<$Res> get gradingSystem {
    return $GradingSystemCopyWith<$Res>(_value.gradingSystem, (value) {
      return _then(_value.copyWith(gradingSystem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConfigImplCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$ConfigImplCopyWith(
          _$ConfigImpl value, $Res Function(_$ConfigImpl) then) =
      __$$ConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ThemeMode themeMode,
      @ColorConverter() Color colorTheme,
      String backgroundImage,
      StudyWeek studyWeek,
      GradingSystem gradingSystem,
      int periodCount,
      RepeatSchedule repeatSchedule});

  @override
  $StudyWeekCopyWith<$Res> get studyWeek;
  @override
  $GradingSystemCopyWith<$Res> get gradingSystem;
}

/// @nodoc
class __$$ConfigImplCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$ConfigImpl>
    implements _$$ConfigImplCopyWith<$Res> {
  __$$ConfigImplCopyWithImpl(
      _$ConfigImpl _value, $Res Function(_$ConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? themeMode = null,
    Object? colorTheme = null,
    Object? backgroundImage = null,
    Object? studyWeek = null,
    Object? gradingSystem = null,
    Object? periodCount = null,
    Object? repeatSchedule = null,
  }) {
    return _then(_$ConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      colorTheme: null == colorTheme
          ? _value.colorTheme
          : colorTheme // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundImage: null == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String,
      studyWeek: null == studyWeek
          ? _value.studyWeek
          : studyWeek // ignore: cast_nullable_to_non_nullable
              as StudyWeek,
      gradingSystem: null == gradingSystem
          ? _value.gradingSystem
          : gradingSystem // ignore: cast_nullable_to_non_nullable
              as GradingSystem,
      periodCount: null == periodCount
          ? _value.periodCount
          : periodCount // ignore: cast_nullable_to_non_nullable
              as int,
      repeatSchedule: null == repeatSchedule
          ? _value.repeatSchedule
          : repeatSchedule // ignore: cast_nullable_to_non_nullable
              as RepeatSchedule,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigImpl implements _Config {
  const _$ConfigImpl(
      {required this.id,
      required this.themeMode,
      @ColorConverter() required this.colorTheme,
      required this.backgroundImage,
      required this.studyWeek,
      required this.gradingSystem,
      required this.periodCount,
      required this.repeatSchedule});

  factory _$ConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigImplFromJson(json);

  @override
  final String id;
  @override
  final ThemeMode themeMode;
  @override
  @ColorConverter()
  final Color colorTheme;
  @override
  final String backgroundImage;
  @override
  final StudyWeek studyWeek;
  @override
  final GradingSystem gradingSystem;
  @override
  final int periodCount;
  @override
  final RepeatSchedule repeatSchedule;

  @override
  String toString() {
    return 'Config(id: $id, themeMode: $themeMode, colorTheme: $colorTheme, backgroundImage: $backgroundImage, studyWeek: $studyWeek, gradingSystem: $gradingSystem, periodCount: $periodCount, repeatSchedule: $repeatSchedule)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.colorTheme, colorTheme) ||
                other.colorTheme == colorTheme) &&
            (identical(other.backgroundImage, backgroundImage) ||
                other.backgroundImage == backgroundImage) &&
            (identical(other.studyWeek, studyWeek) ||
                other.studyWeek == studyWeek) &&
            (identical(other.gradingSystem, gradingSystem) ||
                other.gradingSystem == gradingSystem) &&
            (identical(other.periodCount, periodCount) ||
                other.periodCount == periodCount) &&
            (identical(other.repeatSchedule, repeatSchedule) ||
                other.repeatSchedule == repeatSchedule));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, themeMode, colorTheme,
      backgroundImage, studyWeek, gradingSystem, periodCount, repeatSchedule);

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      __$$ConfigImplCopyWithImpl<_$ConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigImplToJson(
      this,
    );
  }
}

abstract class _Config implements Config {
  const factory _Config(
      {required final String id,
      required final ThemeMode themeMode,
      @ColorConverter() required final Color colorTheme,
      required final String backgroundImage,
      required final StudyWeek studyWeek,
      required final GradingSystem gradingSystem,
      required final int periodCount,
      required final RepeatSchedule repeatSchedule}) = _$ConfigImpl;

  factory _Config.fromJson(Map<String, dynamic> json) = _$ConfigImpl.fromJson;

  @override
  String get id;
  @override
  ThemeMode get themeMode;
  @override
  @ColorConverter()
  Color get colorTheme;
  @override
  String get backgroundImage;
  @override
  StudyWeek get studyWeek;
  @override
  GradingSystem get gradingSystem;
  @override
  int get periodCount;
  @override
  RepeatSchedule get repeatSchedule;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
