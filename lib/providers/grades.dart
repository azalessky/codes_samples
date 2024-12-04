import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/common/common.dart';

part 'grades.g.dart';

@Riverpod(keepAlive: true)
class Grades extends _$Grades with SerializableList<Grade> {
  @mustCallSuper
  @override
  List<Grade> build() => super.build();

  @override
  get repository => (
        saveLocal: localRepository.saveGrades,
        saveRemote: remoteRepository.saveGrades,
        loadLocal: localRepository.loadGrades,
        loadRemote: remoteRepository.loadGrades,
      );

  @override
  get values => (
        initialize: () => [],
        sort: null,
      );

  // void addNote(String text) {
  //   addItem(Note.empty().copyWith(text: text));
  // }

  // void updateNote(String id, String text) {
  //   updateItem(id, (item) => item.copyWith(text: text));
  // }
}
