import 'package:collection/collection.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

mixin SerializableList<T extends Serializable> {
  List<T> get state;
  set state(List<T> values);

  ({
    void Function(List<T>) saveLocal,
    void Function(List<T>) saveRemote,
    List<T>? Function() loadLocal,
    List<T>? Function() loadRemote,
  }) get repository;

  ({
    List<T> Function() initialize,
    Function()? sort,
  }) get values;

  List<T> build() {
    remoteRepository.updates.listen((_) => syncData());
    return loadData();
  }

  T? getItem(String id) {
    return state.singleWhereOrNull((e) => e.id == id);
  }

  void addItem(T item, [bool persist = true]) {
    state.add(item);
    if (persist) saveData();
  }

  void removeItem(String id, [bool persist = true]) {
    state.removeWhere((e) => e.id == id);
    if (persist) saveData();
  }

  void updateItem(String id, T Function(T item) update, [bool persist = true]) {
    final index = state.indexWhere((e) => e.id == id);
    if (index >= 0) {
      state[index] = update(state[index]);
      if (persist) saveData();
    }
  }

  void saveData() {
    values.sort?.call();
    state = [...state];
    repository.saveLocal(state);
    repository.saveRemote(state);
  }

  List<T> loadData() {
    final data = repository.loadRemote();
    if (data != null) {
      repository.saveLocal(data);
      return data;
    }
    return repository.loadLocal() ?? values.initialize();
  }

  void syncData() {
    final data = repository.loadRemote();
    if (data != null && data.differs(state)) {
      state = data;
      repository.saveLocal(state);
    }
  }

  void resetData() {
    state.clear();
    state.addAll(values.initialize());
    saveData();
  }
}
