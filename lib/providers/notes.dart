import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/common/common.dart';

part 'notes.g.dart';

@Riverpod(keepAlive: true)
class Notes extends _$Notes with SerializableList<Note> {
  @mustCallSuper
  @override
  List<Note> build() => super.build();

  @override
  get repository => (
        saveLocal: localRepository.saveNotes,
        saveRemote: remoteRepository.saveNotes,
        loadLocal: localRepository.loadNotes,
        loadRemote: remoteRepository.loadNotes,
      );

  @override
  get values => (
        initialize: () => [],
        sort: null,
      );

  void addNote(String text) {
    addItem(Note.empty().copyWith(text: text));
  }

  void updateNote(String id, String text) {
    updateItem(id, (item) => item.copyWith(text: text));
  }
}
