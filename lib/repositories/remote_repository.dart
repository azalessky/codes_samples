import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/repositories/repositories.dart';

class RemoteRepository extends DataListener {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<DocumentSnapshot<UserData>?> loadUserDocument([User? user]) async {
    final userId = user == null ? auth.currentUser?.uid : user.uid;
    if (userId == null) return null;

    final collection = firestore.collection(RepositorySettings.rootCollection);
    final doc = await collection.doc(userId).get();
    return doc;
  }

  @override
  Future<UserData?> loadUserData([User? user]) async {
    final doc = await loadUserDocument(user);
    return doc?.data();
  }

  void saveAccount(Account value) => _saveObject('account', value);
  Account? loadAccount() => _loadObject('account', Account.fromJson);

  void saveBells(List<Bell> values) => _saveObjectList('bells', values);
  List<Bell>? loadBells() => _loadObjectList('bells', Bell.fromJson);

  void saveNotes(List<Note> values) => _saveObjectList('notes', values);
  List<Note>? loadNotes() => _loadObjectList('notes', Note.fromJson);

  void savePeriods(List<Period> values) => _saveObjectList('periods', values);
  List<Period>? loadPeriods() => _loadObjectList('periods', Period.fromJson);

  void saveGrades(List<Grade> values) => _saveObjectList('grades', values);
  List<Grade>? loadGrades() => _loadObjectList('grades', Grade.fromJson);

  void saveSettings(Config value) => _saveObject('settings', value);
  Config? loadSettings() => _loadObject('settings', Config.fromJson);

  void saveSubjects(List<Subject> values) => _saveObjectList('subjects', values);
  List<Subject>? loadSubjects() => _loadObjectList('subjects', Subject.fromJson);

  void saveTeachers(List<Teacher> values) => _saveObjectList('teachers', values);
  List<Teacher>? loadTeachers() => _loadObjectList('teachers', Teacher.fromJson);

  void saveTerms(List<Term> values) => _saveObjectList('terms', values);
  List<Term>? loadTerms() => _loadObjectList('terms', Term.fromJson);

  Future<void> _saveObject<T extends Serializable>(String key, T value) async {
    final data = value.toJson();
    return _saveJsonData(key, data);
  }

  Future<void> _saveObjectList<T extends Serializable>(String key, List<T> values) async {
    final data = values.map((e) => e.toJson()).toList();
    return _saveJsonData(key, data);
  }

  Future<void> _saveJsonData(String key, dynamic data) async {
    final doc = await loadUserDocument();
    if (doc == null) return;

    final ref = doc.reference;
    return doc.exists ? ref.update({key: data}) : ref.set({key: data});
  }

  T? _loadObject<T extends Serializable>(String key, T Function(JsonData) fromJson) {
    final json = userData?[key];
    if (json == null) return null;
    //return fromJson(json);

    // TODO: Remove this code after full migration to 3.15.0
    var migrated = false;
    if (json != null) {
      migrated = DataMigration.migrateTo_3_15_0(json);
    }
    final result = fromJson(json);
    if (migrated) _saveObject(key, result);
    return result;
  }

  List<T>? _loadObjectList<T extends Serializable>(String key, T Function(JsonData) fromJson) {
    final json = userData?[key];
    if (json == null) return null;

    // TODO: Remove this code after full migration to 3.15.0
    if (json is JsonData && json['list'] != null) {
      final result = json['list'].map<T>((e) {
        DataMigration.migrateTo_3_15_0(e);
        return fromJson(e);
      }).toList();
      _saveObjectList(key, result);
      return result;
    } else {
      return json.map<T>((e) => fromJson(e)).toList();
    }
  }
}
