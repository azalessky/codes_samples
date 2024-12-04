import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/common/common.dart';

part 'bells.g.dart';

@Riverpod(keepAlive: true)
class Bells extends _$Bells with SerializableList<Bell> {
  @override
  List<Bell> build() {
    ref.listen(settingsProvider, (_, settings) => setCount(settings.periodCount));
    return super.build();
  }

  @override
  get repository => (
        saveLocal: localRepository.saveBells,
        saveRemote: remoteRepository.saveBells,
        loadLocal: localRepository.loadBells,
        loadRemote: remoteRepository.loadBells,
      );

  @override
  get values => (
        initialize: () => [],
        sort: null,
      );

  void updateStart(String id, TimeOfDay start) {
    updateItem(id, (item) => item.copyWith(start: start));
  }

  void updateEnd(String id, TimeOfDay end) {
    updateItem(id, (item) => item.copyWith(end: end));
  }

  void setCount(int count) {
    if (count == state.length) {
      return;
    } else if (count < state.length) {
      state.removeRange(count - 1, state.length - 1);
    } else if (count > state.length) {
      state.addAll(List.generate(count - state.length, (index) => Bell.empty()));
    }
    saveData();
  }

  Duration calcRecess(int index) {
    if (index == state.length - 1) return Duration.zero;
    if (state[index + 1].start.isZero || state[index].end.isZero) return Duration.zero;
    return state[index + 1].start.difference(state[index].end);
  }
}
