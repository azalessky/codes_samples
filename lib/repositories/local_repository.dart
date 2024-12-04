import 'dart:convert';

import 'package:homework_planner/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:homework_planner/models/models.dart';

class LocalRepository {
  final SharedPreferences prefs;

  const LocalRepository(this.prefs);

  void saveAccount(Account value) => _saveObject('account', value);
  Account? loadAccount() => _loadObject('account', Account.fromJson);

  void saveBells(List<Bell> values) => _saveObjectList('bells2', values);
  List<Bell>? loadBells() => _loadObjectList('bells2', Bell.fromJson);

  void saveNotes(List<Note> values) => _saveObjectList('notes', values);
  List<Note>? loadNotes() => _loadObjectList('notes', Note.fromJson);

  void savePeriods(List<Period> values) => _saveObjectList('periods2', values);
  List<Period>? loadPeriods() => _loadObjectList('periods2', Period.fromJson);

  void saveGrades(List<Grade> values) => _saveObjectList('grades', values);
  List<Grade>? loadGrades() => _loadObjectList('grades', Grade.fromJson);

  void saveSettings(Config value) => _saveObject('settings2', value);
  Config? loadSettings() => _loadObject('settings2', Config.fromJson);

  void saveSubjects(List<Subject> values) => _saveObjectList('subjects2', values);
  List<Subject>? loadSubjects() => _loadObjectList('subjects2', Subject.fromJson);

  void saveTeachers(List<Teacher> values) => _saveObjectList('teachers2', values);
  List<Teacher>? loadTeachers() => _loadObjectList('teachers2', Teacher.fromJson);

  void saveTerms(List<Term> values) => _saveObjectList('terms2', values);
  List<Term>? loadTerms() => _loadObjectList('terms2', Term.fromJson);

  void _saveObject(String key, Object value) {
    prefs.setString(key, jsonEncode(value));
  }

  void _saveObjectList(String key, List values) {
    final data = values.map((e) => jsonEncode(e)).toList();
    prefs.setStringList(key, data);
  }

  T? _loadObject<T>(String key, T Function(JsonData) fromJson) {
    final data = prefs.getString(key);
    if (data == null) return null;
    // return fromJson(jsonDecode(data));

    // TODO: Remove this code after full migration to 3.15.0
    var migrated = false;
    final json = jsonDecode(data);
    if (json != null) {
      migrated = DataMigration.migrateTo_3_15_0(json);
    }
    final result = fromJson(json);
    if (migrated && result != null) _saveObject(key, result);
    return result;
  }

  List<T>? _loadObjectList<T>(String key, T Function(JsonData) fromJson) {
    final data = prefs.getStringList(key);
    //  return data?.map<T>((e) => fromJson(jsonDecode(e))).toList();

    // TODO: Remove this code after full migration to 3.15.0
    var migrated = false;
    final result = data?.map<T>((e) {
      final json = jsonDecode(e);
      if (json != null) {
        migrated = DataMigration.migrateTo_3_15_0(json);
      }
      return fromJson(json);
    }).toList();

    if (migrated && result != null) _saveObjectList(key, result);
    return result;
  }
}
