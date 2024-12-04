import 'package:homework_planner/models/models.dart';

abstract class Serializable {
  String get id;
  JsonData toJson();
}
