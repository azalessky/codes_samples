import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

part 'config.freezed.dart';
part 'config.g.dart';

enum RepeatSchedule {
  never,
  weekly,
  biweekly,
}

@freezed
class Config with _$Config implements Serializable {
  const factory Config({
    required String id,
    required ThemeMode themeMode,
    @ColorConverter() required Color colorTheme,
    required String backgroundImage,
    required StudyWeek studyWeek,
    required GradingSystem gradingSystem,
    required int periodCount,
    required RepeatSchedule repeatSchedule,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.initial() => Config(
        id: UuidHelper.objectId(),
        themeMode: DefaultSettings.themeMode,
        colorTheme: DefaultSettings.colorTheme,
        backgroundImage: DefaultSettings.backgroundImage,
        studyWeek: StudyWeek(week: DefaultSettings.studyWeek),
        gradingSystem: GradingSystem(scale: DefaultSettings.gradingScale),
        periodCount: DefaultSettings.periodCount,
        repeatSchedule: RepeatSchedule.never,
      );
}
