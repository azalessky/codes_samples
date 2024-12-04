import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/models/models.dart';

part 'settings.g.dart';

@Riverpod(keepAlive: true)
class Settings extends _$Settings with SerializableItem<Config> {
  @mustCallSuper
  @override
  Config build() => super.build();

  @override
  get repository => (
        saveLocal: localRepository.saveSettings,
        saveRemote: remoteRepository.saveSettings,
        loadLocal: localRepository.loadSettings,
        loadRemote: remoteRepository.loadSettings,
        defaultValue: () => Config.initial(),
      );

  set themeMode(ThemeMode value) {
    state = state.copyWith(themeMode: value);
    saveData();
  }

  set colorTheme(Color value) {
    state = state.copyWith(colorTheme: value);
    saveData();
  }

  set backgroundImage(String value) {
    state = state.copyWith(backgroundImage: value);
    saveData();
  }

  set studyWeek(StudyWeek value) {
    state = state.copyWith(studyWeek: value);
    saveData();
  }

  set gradingSystem(GradingSystem value) {
    state = state.copyWith(gradingSystem: value);
    saveData();
  }

  set periodCount(int value) {
    state = state.copyWith(periodCount: value);
    saveData();
  }

  set repeatSchedule(RepeatSchedule value) {
    state = state.copyWith(repeatSchedule: value);
    saveData();
  }
}
