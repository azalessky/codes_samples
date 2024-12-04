import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';

part 'term.freezed.dart';
part 'term.g.dart';

enum TermType {
  study,
  holiday,
}

@freezed
class Term with _$Term implements Serializable {
  const factory Term({
    required String id,
    required TermType type,
    required String name,
    required DateTime start,
    required DateTime end,
  }) = _Term;

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);

  factory Term.empty() => Term(
        id: UuidHelper.objectId(),
        type: TermType.study,
        name: '',
        start: DateTime.now(),
        end: DateTime.now(),
      );
}
