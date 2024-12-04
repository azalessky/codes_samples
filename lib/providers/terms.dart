import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';

part 'terms.g.dart';

@Riverpod(keepAlive: true)
class Terms extends _$Terms with SerializableList<Term> {
  static const maxStudyTerms = 4;

  @mustCallSuper
  @override
  List<Term> build() => super.build();

  @override
  get repository => (
        saveLocal: localRepository.saveTerms,
        saveRemote: remoteRepository.saveTerms,
        loadLocal: localRepository.loadTerms,
        loadRemote: remoteRepository.loadTerms,
      );

  @override
  get values => (
        initialize: () => [],
        sort: _sortItems,
      );

  List<Term> get studyTerms => state.where((e) => e.type == TermType.study).toList();

  void addTerm(TermType type, String name, DateTime start, DateTime end) {
    addItem(
      Term.empty().copyWith(type: type, name: name, start: start, end: end),
    );
  }

  void updateTerm(String id, TermType type, String name, DateTime start, DateTime end) {
    updateItem(
      id,
      (item) => item.copyWith(type: type, name: name, start: start, end: end),
    );
  }

  Term? findTerm(DateTime date, TermType type) {
    return state.firstWhereOrNull(
      (t) => t.type == type && date.inRange(t.start, t.end),
    );
  }

  bool isHoliday(DateTime date) {
    return state.indexWhere((t) => t.type == TermType.holiday && date.inRange(t.start, t.end)) >= 0;
  }

  bool isStudy(DateTime date) {
    return !isHoliday(date) &&
        (state.indexWhere((t) => t.type == TermType.study) < 0 ||
            state.indexWhere((t) => t.type == TermType.study && date.inRange(t.start, t.end)) >= 0);
  }

  bool canAddTerm(TermType type) {
    if (type != TermType.study) return true;
    final count = studyTerms.length + 1;
    return count <= maxStudyTerms;
  }

  bool canUpdateTerm(String id, TermType type) {
    if (type != TermType.study) return true;
    final term = getItem(id);
    final count = studyTerms.length + (term!.type == TermType.study ? 0 : 1);
    return count <= maxStudyTerms;
  }

  void _sortItems() {
    state.sort((a, b) => a.start.compareTo(b.start));
  }
}
