// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermImpl _$$TermImplFromJson(Map<String, dynamic> json) => _$TermImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TermTypeEnumMap, json['type']),
      name: json['name'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$$TermImplToJson(_$TermImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TermTypeEnumMap[instance.type]!,
      'name': instance.name,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };

const _$TermTypeEnumMap = {
  TermType.study: 'study',
  TermType.holiday: 'holiday',
};
