import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'grading_system.freezed.dart';
part 'grading_system.g.dart';

enum GradingScale {
  numeric5,
  numeric6,
  numeric10,
  numeric12,
  alphabeticAF,
  none,
}

@freezed
class GradingSystem with _$GradingSystem {
  static const Map<GradingScale, String> gradingScales = {
    GradingScale.numeric5: '1,2,3,4,5',
    GradingScale.numeric6: '1,2,3,4,5,6',
    GradingScale.numeric10: '1,2,3,4,5,6,7,8,9,10',
    GradingScale.numeric12: '1,2,3,4,5,6,7,8,9,10,11,12',
    GradingScale.alphabeticAF: 'F,D-,D,D+,C-,C,C+,B-,B,B+,A-,A,A+',
    GradingScale.none: '',
  };

  static const Map<int, Color> gradeColors = {
    0: Colors.white,
    1: Colors.red,
    2: Colors.red,
    3: Colors.orange,
    4: Colors.green,
    5: Colors.green,
  };

  static const gpaTable = {
    'F': 0.00,
    'D-': 0.67,
    'D': 1.00,
    'D+': 1.33,
    'C-': 1.67,
    'C': 2.00,
    'C+': 2.33,
    'B-': 2.67,
    'B': 3.00,
    'B+': 3.33,
    'A-': 3.67,
    'A': 4.00,
    'A+': 4.33,
  };

  const GradingSystem._();

  const factory GradingSystem({required GradingScale scale}) = _GradingScale;

  List<String> get scales => gradingScales.keys.map((e) => e.name).toList();
  List<String> get values => gradingScales[scale]!.split(',');

  factory GradingSystem.fromJson(Map<String, dynamic> json) => _$GradingSystemFromJson(json);

  Color gradeColor(String grade) {
    final value = _normalizeGrade(grade);
    return gradeColors[value]!;
  }

  String averageGrade(List<String> grades) {
    if (grades.isEmpty) return '-';

    switch (scale) {
      case GradingScale.numeric5:
      case GradingScale.numeric6:
      case GradingScale.numeric10:
      case GradingScale.numeric12:
        return _averageNumeric(grades);
      case GradingScale.alphabeticAF:
        return _averageAlphabetic(grades);
      case GradingScale.none:
        return '-';
    }
  }

  String _averageNumeric(List<String> grades) {
    final data = grades.where((e) => values.contains(e));
    if (data.isEmpty) return '-';

    final parsed = data.map((e) => int.tryParse(e) ?? 0);
    return parsed.average.round().toString();
  }

  String _averageAlphabetic(List<String> grades) {
    final data = grades.where((e) => values.contains(e));
    if (data.isEmpty) return '-';

    final parsed = data.map((e) => gpaTable[e] ?? 0);
    return gpaTable.keys.firstWhere((e) => gpaTable[e] == parsed.average.round());
  }

  int _normalizeGrade(String grade) {
    final value = values.indexOf(grade) + 1;
    switch (scale) {
      case GradingScale.numeric5:
        return value;
      case GradingScale.numeric6:
        return _normalizeNumeric6(value);
      case GradingScale.numeric10:
        return _normalizeNumeric10(value);
      case GradingScale.numeric12:
        return _normalizeNumeric12(value);
      case GradingScale.alphabeticAF:
        return _normalizeAlphabeticAF(value);
      case GradingScale.none:
        return 0;
    }
  }

  int _normalizeNumeric6(int grade) {
    if (grade >= 5) return 5;
    if (grade >= 4) return 3;
    if (grade >= 3) return 3;
    return 2;
  }

  int _normalizeNumeric10(int grade) {
    if (grade >= 8) return 5;
    if (grade >= 6) return 4;
    if (grade >= 4) return 3;
    return 2;
  }

  int _normalizeNumeric12(int grade) {
    if (grade >= 10) return 5;
    if (grade >= 7) return 4;
    if (grade >= 4) return 3;
    return 2;
  }

  int _normalizeAlphabeticAF(int grade) {
    if (grade >= 11) return 5;
    if (grade >= 5) return 4;
    if (grade >= 2) return 3;
    return 2;
  }
}
