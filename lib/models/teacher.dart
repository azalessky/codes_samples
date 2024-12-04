import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

part 'teacher.freezed.dart';
part 'teacher.g.dart';

@freezed
class Teacher with _$Teacher implements Serializable {
  const factory Teacher({
    required String id,
    required String name,
    required String subject,
    required String note,
    required String avatar,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);

  factory Teacher.empty() => Teacher(
        id: UuidHelper.objectId(),
        name: '',
        subject: '',
        note: '',
        avatar: '',
      );
}
