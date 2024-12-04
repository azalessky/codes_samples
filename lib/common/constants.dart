import 'package:flutter/material.dart';

import 'package:homework_planner/models/models.dart';

class DefaultSettings {
  static const themeMode = ThemeMode.dark;
  static const colorTheme = Color(0xFF8BC34A);
  static const backgroundImage = 'groceries';
  static const studyWeek = [true, true, true, true, true, true, false];
  static const gradingScale = GradingScale.numeric5;
  static const periodCount = 8;
}

class FieldConstraints {
  static const homeworkTexLength = 200;
  static const noteTextLength = 1000;
  static const subjectNameLength = 50;
  static const subjectRoomLength = 10;
  static const teacherNameLength = 50;
  static const teacherNoteLength = 50;
  static const termNameLength = 50;
}

class RepositorySettings {
  static const rootCollection = 'users';
}

class ScheduleSettings {
  static const maxWeekCount = 1000;
}

class FormLayout {
  static const contentPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 12);
  static const defaultSpacer = SizedBox.square(dimension: 8);
  static const largeSpacer = SizedBox.square(dimension: 24);
  static const textSpacer = SizedBox.square(dimension: 16);
  static const inputSpacer = SizedBox.square(dimension: 20);
}

class DialogPaddings {
  static const iOSDialog = EdgeInsets.only(top: 4, bottom: 32);
  static const androidDialog = EdgeInsets.only(top: 8, bottom: 24);

  static const dialogTitle = EdgeInsets.only(top: 16);
  static const defaultContent = EdgeInsets.symmetric(vertical: 8);

  static const pickerContent = EdgeInsets.symmetric(vertical: 24);
  static const inputContent = EdgeInsets.symmetric(horizontal: 24, vertical: 20);
  static const promptContent = EdgeInsets.symmetric(horizontal: 32, vertical: 24);

  static const valueContent = EdgeInsets.symmetric(vertical: 4);
  static const valueTile = EdgeInsets.symmetric(horizontal: 24);
}

class ResourceSettings {
  static const subjectsAsset = 'assets/settings/subjects.json';
  static const subjectsResource = 'subjects.json';
}

class AdSettings {
  static const adUnitId = 'R-M-13183099-1';
  static const demoUnitId = 'demo-banner-yandex';
  static const maxHeight = 50.0;
  static const bannerPadding = EdgeInsets.only(top: 4, bottom: 8);
  static const rotationDuration = Duration(seconds: 30);
}
