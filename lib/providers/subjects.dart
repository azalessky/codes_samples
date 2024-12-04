import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/common/common.dart';

part 'subjects.g.dart';

@Riverpod(keepAlive: true)
class Subjects extends _$Subjects with SerializableList<Subject> {
  @mustCallSuper
  @override
  List<Subject> build() => super.build();

  @override
  get repository => (
        saveLocal: localRepository.saveSubjects,
        saveRemote: remoteRepository.saveSubjects,
        loadLocal: localRepository.loadSubjects,
        loadRemote: remoteRepository.loadSubjects,
      );

  @override
  get values => (
        initialize: _loadDefault,
        sort: _sortItems,
      );

  List<String> get names => state.map((e) => e.name).toList();

  void addSubject(String name, String room) {
    addItem(Subject.empty().copyWith(name: name, room: room));
  }

  void updateSubject(String id, String name, String room) {
    updateItem(id, (item) => item.copyWith(name: name, room: room));
  }

  List<Subject> _loadDefault() {
    final data = jsonDecode(getIt.get<String>(instanceName: ResourceSettings.subjectsResource));
    final lang = Intl.shortLocale(Intl.getCurrentLocale());

    final subjects = data.containsKey(lang) ? data[lang] : data['en'];
    final items = subjects.map<Subject>((e) => Subject.empty().copyWith(name: e['name'])).toList();

    return items;
  }

  void _sortItems() {
    state.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
}
