import 'package:uuid/uuid.dart';

class UuidHelper {
  static String objectId() {
    String uuid = Uuid().v4().replaceAll('-', '');
    return uuid;
  }
}
