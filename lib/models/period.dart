import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

part 'period.freezed.dart';
part 'period.g.dart';

@freezed
class Period with _$Period implements Serializable {
  const Period._();

  const factory Period({
    required String id,
    required DateTime date,
    required int slot,
    required String subject,
    required String grade,
    required Homework homework,
  }) = _Period;

  bool isSameSlot(DateTime dateOther, int slotOther) =>
      DateUtils.isSameDay(date, dateOther) && slot == slotOther;

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);

  factory Period.empty() => Period(
        id: UuidHelper.objectId(),
        date: DateTime.now(),
        slot: 0,
        subject: '',
        grade: '',
        homework: Homework.empty(),
      );
}
