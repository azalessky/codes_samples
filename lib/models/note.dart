import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note implements Serializable {
  const factory Note({
    required String id,
    required String text,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  factory Note.empty() => Note(
        id: UuidHelper.objectId(),
        text: '',
      );
}
