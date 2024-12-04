// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GradeImpl _$$GradeImplFromJson(Map<String, dynamic> json) => _$GradeImpl(
      id: json['id'] as String,
      type: $enumDecode(_$GradeTypeEnumMap, json['type']),
      value: json['value'] as String,
    );

Map<String, dynamic> _$$GradeImplToJson(_$GradeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$GradeTypeEnumMap[instance.type]!,
      'value': instance.value,
    };

const _$GradeTypeEnumMap = {
  GradeType.lesson: 'lesson',
  GradeType.term: 'term',
  GradeType.year: 'year',
};
