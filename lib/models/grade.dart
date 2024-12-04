import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

part 'grade.freezed.dart';
part 'grade.g.dart';

enum GradeType { lesson, term, year }

@freezed
class Grade with _$Grade implements Serializable {
  const factory Grade({
    required String id,
    required GradeType type,
    required String value,
  }) = _Grade;

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);

  factory Grade.empty() => Grade(
        id: UuidHelper.objectId(),
        type: GradeType.lesson,
        value: '',
      );
}
