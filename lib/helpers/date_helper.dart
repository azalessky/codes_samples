import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'string_helper.dart';

class DateHelper {
  static final minDate = DateTime(2000);
  static final maxDate = DateTime(2100);

  static DateTime getDateForWeekDay(DateTime dateIndex, int weekDay) {
    DateTime weekStart = dateIndex.subtract(Duration(days: dateIndex.weekday - 1));
    return weekStart.add(Duration(days: weekDay - 1));
  }

  static String getAbbrNameOfWeekDay(int weekday) {
    return DateFormat('E')
        .format(
          getDateForWeekDay(DateTime.now(), weekday),
        )
        .capitalized;
  }

  static List<String> getNamesOfWeekDays() {
    return List<String>.generate(
      DateTime.daysPerWeek,
      (index) => DateFormat('EEEE')
          .format(getDateForWeekDay(
            DateTime.now(),
            index + 1,
          ))
          .capitalized,
    );
  }

  static String formatDayMonth(DateTime date) {
    return DateFormat.MMMMEEEEd().format(date);
  }

  static String formatDateRange(DateTime start, DateTime end) {
    return DateUtils.isSameMonth(start, end)
        ? DateUtils.isSameDay(start, end)
            ? DateFormat.yMMMMd().format(start)
            : 'DateFormat.Range'.tr(args: [
                DateFormat.d().format(start),
                DateFormat.yMMMMd().format(end),
              ])
        : 'DateFormat.Range'.tr(args: [
            DateFormat.MMMMd().format(start),
            DateFormat.yMMMMd().format(end),
          ]);
  }

  static String formatDaysAhead(DateTime date) {
    final days = date.differenceInDays(DateTime.now());
    return switch (days) {
      0 => 'DaysAhead.today'.tr(),
      1 => 'DaysAhead.tomorrow'.tr(),
      _ => 'DaysAhead'.plural(days),
    };
  }
}

extension DateTimeExtension on DateTime {
  TimeOfDay toTimeOfDay() => TimeOfDay(hour: hour, minute: minute);

  bool inRange(DateTime start, DateTime end) => compareTo(start) >= 0 && compareTo(end) <= 0;

  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool isSameWeek(DateTime other) =>
      DateTime(year, month, day - weekday) ==
      DateTime(other.year, other.month, other.day - other.weekday);

  int differenceInDays(DateTime other) {
    DateTime start = DateTime(year, month, day);
    DateTime end = DateTime(other.year, other.month, other.day);
    return start.difference(end).inDays;
  }
}
