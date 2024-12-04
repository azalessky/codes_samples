// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PeriodImpl _$$PeriodImplFromJson(Map<String, dynamic> json) => _$PeriodImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      slot: (json['slot'] as num).toInt(),
      subject: json['subject'] as String,
      grade: json['grade'] as String,
      homework: Homework.fromJson(json['homework'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PeriodImplToJson(_$PeriodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'slot': instance.slot,
      'subject': instance.subject,
      'grade': instance.grade,
      'homework': instance.homework.toJson(),
    };
