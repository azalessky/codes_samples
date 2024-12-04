import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

extension TimeofDayExtension on TimeOfDay {
  bool get isZero => hour == 0 && minute == 0;

  Duration difference(TimeOfDay other) =>
      Duration(minutes: hour * 60 + minute - other.hour * 60 - other.minute);

  TimeOfDay addMinutes(int minutes) {
    int total = hour * 60 + minute + minutes;
    return TimeOfDay(hour: (total ~/ 60) % 24, minute: total % 60);
  }
}

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String?> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String? json) => TimeOfDay(
        hour: int.parse(json!.split(":")[0]),
        minute: int.parse(json.split(":")[1]),
      );

  @override
  String? toJson(TimeOfDay value) {
    String addLeadingZero(int value) {
      return value < 10 ? '0$value' : value.toString();
    }

    final hours = addLeadingZero(value.hour);
    final minutes = addLeadingZero(value.minute);
    return '$hours:$minutes';
  }
}
