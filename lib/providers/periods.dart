import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/helpers/helpers.dart';

part 'periods.g.dart';

@Riverpod(keepAlive: true)
class Periods extends _$Periods with SerializableList<Period> {
  static const repeatMaxWeeks = 52;

  @mustCallSuper
  @override
  List<Period> build() => super.build();

  @override
  get repository => (
        saveLocal: localRepository.savePeriods,
        saveRemote: remoteRepository.savePeriods,
        loadLocal: localRepository.loadPeriods,
        loadRemote: remoteRepository.loadPeriods,
      );

  @override
  get values => (
        initialize: () => [],
        sort: _sortItems,
      );

  void updatePeriod(Period period, [RepeatSchedule? repeat]) {
    final item = getItem(period.id);
    if (item == null) {
      addItem(period, false);
    } else {
      updateItem(period.id, (item) => period, false);
    }
    if (repeat != null) _repeatItem(period, repeat);
    saveData();
  }

  Period? getPeriod(DateTime date, int slot) {
    return state.firstWhereOrNull((p) => p.isSameSlot(date, slot));
  }

  List<Period> getPeriods(DateTime date, int count) {
    return List<Period>.generate(count, (index) => _getItem(date, index + 1));
  }

  GradeBook getGradeBook(DateTime start, DateTime end) {
    final periods = getRange(start, end);
    final data = periods.where((e) => e.subject.isNotEmpty && e.grade.isNotEmpty).toList();

    final subjects = data.map((s) => s.subject).toSet().toList();
    subjects.sort((a, b) => a.compareTo(b));

    final result = {
      for (final subject in subjects)
        subject: data.where((e) => e.subject == subject).map((e) => e.grade).toList(),
    };
    return result;
  }

  GradeReport getGradeReport(List<Term> terms, GradingSystem scale) {
    if (terms.isEmpty) return {};

    final periods = getRange(terms.first.start, terms.last.end);
    final data = periods.where((e) => e.subject.isNotEmpty && e.grade.isNotEmpty).toList();

    final subjects = data.map((e) => e.subject).toSet().toList();
    subjects.sort((a, b) => a.compareTo(b));

    final result = {
      for (final subject in subjects)
        subject: [
          for (final term in terms)
            scale.averageGrade(
              data
                  .where((e) => e.date.inRange(term.start, term.end))
                  .where((e) => e.subject == subject)
                  .map((e) => e.grade)
                  .toList(),
            )
        ],
    };

    result.forEach(
      (subject, grades) => grades.add(
        scale.averageGrade(result[subject]!.where((e) => e != '-').toList()),
      ),
    );
    return result;
  }

  GradesHistory getGradesHistory(String subject, DateTime start, DateTime end) {
    final periods = getRange(start, end);
    final data = periods.where((e) => e.subject == subject && e.grade.isNotEmpty).toList();
    return data.map((e) => (e.grade, e.date)).toList();
  }

  List<Period> getRange(DateTime start, DateTime end) {
    return state.where((p) => p.date.inRange(start, end)).toList();
  }

  List<Period> getAssignments() {
    final today = DateTime.now();
    return state
        .where((p) =>
            p.subject.isNotEmpty &&
            p.homework.hasTasks &&
            (p.date.isSameDay(today) || p.date.isAfter(today)))
        .toList();
  }

  void repeatPeriods(RepeatSchedule repeat) {
    if (repeat != RepeatSchedule.never) {
      final today = DateUtils.dateOnly(DateTime.now());
      final start = today.add(Duration(days: 1 - today.weekday));
      final end = start.add(const Duration(days: 7));

      getRange(start, end).forEach((e) => _repeatItem(e, repeat));
      saveData();
    }
  }

  void _repeatItem(Period period, RepeatSchedule repeat) {
    if (repeat != RepeatSchedule.never) {
      final offset = switch (repeat) {
        RepeatSchedule.never => 0,
        RepeatSchedule.weekly => 7,
        RepeatSchedule.biweekly => 14,
      };
      final count = repeatMaxWeeks / (offset / 7);

      for (int i = 1; i <= count; i++) {
        final date = period.date.add(Duration(days: i * offset));
        final next = _getItem(date, period.slot);
        _setItem(next.copyWith(subject: period.subject));
      }
    }
  }

  Period _getItem(DateTime date, int slot) {
    return state.firstWhere(
      (p) => p.isSameSlot(date, slot),
      orElse: () => Period.empty().copyWith(date: date, slot: slot),
    );
  }

  void _setItem(Period period) {
    int index = state.indexWhere((p) => p.isSameSlot(period.date, period.slot));
    index < 0 ? state.add(period) : state[index] = period;
  }

  void _sortItems() {
    state.sort((a, b) {
      int diff = a.date.differenceInDays(b.date);
      return diff == 0 ? (a.slot - b.slot) : diff;
    });
  }
}
