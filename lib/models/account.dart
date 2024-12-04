import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homework_planner/helpers/helpers.dart';

import 'package:homework_planner/models/models.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class Account with _$Account implements Serializable {
  const factory Account({
    required String id,
    required String userId,
    required String email,
    required String displayName,
    required String photoUrl,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  factory Account.fromUser(User? user) => Account(
        id: UuidHelper.objectId(),
        userId: user?.uid ?? '',
        email: user?.email ?? '',
        displayName: user?.displayName ?? '',
        photoUrl: user?.photoURL ?? '',
      );
}
