import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/models/models.dart';

mixin SerializableItem<T extends Serializable> {
  T get state;
  set state(T values);

  ({
    void Function(T) saveLocal,
    void Function(T) saveRemote,
    T? Function() loadLocal,
    T? Function() loadRemote,
    T Function() defaultValue,
  }) get repository;

  T build() {
    remoteRepository.updates.listen((_) => syncData());
    return loadData();
  }

  void saveData() {
    repository.saveLocal(state);
    repository.saveRemote(state);
  }

  T loadData() {
    final data = repository.loadRemote();
    if (data != null) {
      repository.saveLocal(data);
      return data;
    }
    return repository.loadLocal() ?? repository.defaultValue();
  }

  void syncData() {
    final data = repository.loadRemote();
    if (data != null && data != state) {
      state = data;
      repository.saveLocal(state);
    }
  }
}
