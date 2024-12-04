import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'homework.freezed.dart';
part 'homework.g.dart';

@freezed
class Homework with _$Homework {
  const Homework._();

  const factory Homework({
    required String text,
    required List<String> images,
    required bool done,
  }) = _Homework;

  bool get hasTasks => text.isNotEmpty && !done;

  factory Homework.fromJson(Map<String, dynamic> json) => _$HomeworkFromJson(json);

  factory Homework.empty() => Homework(
        text: '',
        images: [],
        done: false,
      );
}
