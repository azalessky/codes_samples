import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/helpers/helpers.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

@freezed
class Subject with _$Subject implements Serializable {
  const factory Subject({
    required String id,
    required String name,
    required String room,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);

  factory Subject.empty() => Subject(
        id: UuidHelper.objectId(),
        name: '',
        room: '',
      );
}
