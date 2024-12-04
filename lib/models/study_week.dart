import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:homework_planner/helpers/helpers.dart';

part 'study_week.freezed.dart';
part 'study_week.g.dart';

@freezed
class StudyWeek with _$StudyWeek {
  const StudyWeek._();

  const factory StudyWeek({required List<bool> week}) = _StudyWeek;

  List<int> get days => week.asMap().keys.where((e) => week[e]).map((e) => e + 1).toList();

  String displayText() =>
      days.fold('', (prev, e) => '$prev, ${DateHelper.getAbbrNameOfWeekDay(e)}').substring(2);

  @override
  String toString() => week.fold('', (prev, e) => '$prev${(e ? '1' : '0').toString()}');

  factory StudyWeek.fromJson(Map<String, dynamic> json) => _$StudyWeekFromJson(json);
}
