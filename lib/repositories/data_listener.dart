import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:homework_planner/models/models.dart';

abstract class DataListener {
  final _dataController = StreamController<UserData>.broadcast();

  StreamSubscription? _authSubscription;
  StreamSubscription? _dataSubscription;
  Function? _onUpdate;
  UserData? _userData;

  Stream<UserData> get updates => _dataController.stream;
  UserData? get userData => _userData;

  Future<DocumentSnapshot<UserData>?> loadUserDocument([User? user]);
  Future<UserData?> loadUserData();

  Future<void> sync() async {
    _userData = await loadUserData();
    if (_userData != null) _dataController.add(_userData!);
  }

  Future<void> subscribe([Function()? onUpdate]) async {
    _onUpdate = onUpdate;
    final stream = FirebaseAuth.instance.authStateChanges();
    _authSubscription = stream.listen((user) => _subscribeData());
  }

  void unsubscribe() {
    _authSubscription?.cancel();
    _dataSubscription?.cancel();
  }

  Future<void> _subscribeData() async {
    final doc = await loadUserDocument();
    final stream = doc?.reference.snapshots();

    _dataSubscription?.cancel();
    _dataSubscription = stream?.listen((event) {
      if (!event.metadata.hasPendingWrites && !event.metadata.isFromCache) {
        _fireEvent(event.data()!);
      }
    }, cancelOnError: true);
  }

  void _fireEvent(UserData data) {
    _userData = data;
    _dataController.add(_userData!);
    _onUpdate?.call();
  }
}
