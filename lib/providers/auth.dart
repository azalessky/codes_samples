import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:homework_planner/models/models.dart';

part 'auth.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  final auth = FirebaseAuth.instance;

  @override
  Account build() {
    final subscription = auth.authStateChanges().listen((user) => _updateState(user));
    ref.onDispose(() => subscription.cancel());
    return Account.fromUser(auth.currentUser);
  }

  void _updateState(User? user) {
    state = Account.fromUser(user);
  }
}
