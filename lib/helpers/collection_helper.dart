import 'package:collection/collection.dart';

extension ListExtension<T> on List<T> {
  bool differs(List<T> value) => !equals(value);

  List<T> exclude(T value) {
    var list = toList();
    list.removeWhere((e) => e == value);
    return list;
  }

  List<T> excludeAt(int index) {
    var list = toList();
    list.removeAt(index);
    return list;
  }
}
