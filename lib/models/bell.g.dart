// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BellImpl _$$BellImplFromJson(Map<String, dynamic> json) => _$BellImpl(
      id: json['id'] as String,
      start: const TimeOfDayConverter().fromJson(json['start'] as String?),
      end: const TimeOfDayConverter().fromJson(json['end'] as String?),
    );

Map<String, dynamic> _$$BellImplToJson(_$BellImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': const TimeOfDayConverter().toJson(instance.start),
      'end': const TimeOfDayConverter().toJson(instance.end),
    };
