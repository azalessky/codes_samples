import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

class DataMigration {
  static bool migrateTo_3_15_0(JsonData json) {
    final migrated = json['id'] == null;
    json['id'] ??= UuidHelper.objectId();
    return migrated;
  }
}
