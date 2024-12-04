import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/common/common.dart';

part 'teachers.g.dart';

@Riverpod(keepAlive: true)
class Teachers extends _$Teachers with SerializableList<Teacher> {
  @mustCallSuper
  @override
  List<Teacher> build() => super.build();

  @override
  get repository => (
        saveLocal: localRepository.saveTeachers,
        saveRemote: remoteRepository.saveTeachers,
        loadLocal: localRepository.loadTeachers,
        loadRemote: remoteRepository.loadTeachers,
      );

  @override
  get values => (
        initialize: () => [],
        sort: _sortItems,
      );

  List<String> get names => state.map((e) => e.name).toList();

  void addTeacher(String name, String subject, String note, String avatar) {
    addItem(
      Teacher.empty().copyWith(name: name, subject: subject, note: note, avatar: avatar),
    );
  }

  void updateTeacher(String id, String name, String subject, String note, String avatar) {
    updateItem(
      id,
      (item) => item.copyWith(name: name, subject: subject, note: note, avatar: avatar),
    );
  }

  void _sortItems() {
    state.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
}
