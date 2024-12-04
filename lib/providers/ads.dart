import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/helpers/helpers.dart';

part 'ads.g.dart';

@Riverpod(keepAlive: true)
class Ads extends _$Ads {
  final connectivity = ConnectivityHelper();

  set status(bool status) => state = status;

  @override
  bool build() {
    connectivity.subscribe(
      onConnect: () => state = true,
      onDisconnect: () => state = false,
    );
    ref.onDispose(() => connectivity.unsubscribe());
    return true;
  }
}
