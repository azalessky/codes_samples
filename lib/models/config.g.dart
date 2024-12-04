// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigImpl _$$ConfigImplFromJson(Map<String, dynamic> json) => _$ConfigImpl(
      id: json['id'] as String,
      themeMode: $enumDecode(_$ThemeModeEnumMap, json['themeMode']),
      colorTheme:
          const ColorConverter().fromJson(json['colorTheme'] as String?),
      backgroundImage: json['backgroundImage'] as String,
      studyWeek: StudyWeek.fromJson(json['studyWeek'] as Map<String, dynamic>),
      gradingSystem:
          GradingSystem.fromJson(json['gradingSystem'] as Map<String, dynamic>),
      periodCount: (json['periodCount'] as num).toInt(),
      repeatSchedule:
          $enumDecode(_$RepeatScheduleEnumMap, json['repeatSchedule']),
    );

Map<String, dynamic> _$$ConfigImplToJson(_$ConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'colorTheme': const ColorConverter().toJson(instance.colorTheme),
      'backgroundImage': instance.backgroundImage,
      'studyWeek': instance.studyWeek.toJson(),
      'gradingSystem': instance.gradingSystem.toJson(),
      'periodCount': instance.periodCount,
      'repeatSchedule': _$RepeatScheduleEnumMap[instance.repeatSchedule]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$RepeatScheduleEnumMap = {
  RepeatSchedule.never: 'never',
  RepeatSchedule.weekly: 'weekly',
  RepeatSchedule.biweekly: 'biweekly',
};
