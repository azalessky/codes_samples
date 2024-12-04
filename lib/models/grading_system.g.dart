// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grading_system.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GradingScaleImpl _$$GradingScaleImplFromJson(Map<String, dynamic> json) =>
    _$GradingScaleImpl(
      scale: $enumDecode(_$GradingScaleEnumMap, json['scale']),
    );

Map<String, dynamic> _$$GradingScaleImplToJson(_$GradingScaleImpl instance) =>
    <String, dynamic>{
      'scale': _$GradingScaleEnumMap[instance.scale]!,
    };

const _$GradingScaleEnumMap = {
  GradingScale.numeric5: 'numeric5',
  GradingScale.numeric6: 'numeric6',
  GradingScale.numeric10: 'numeric10',
  GradingScale.numeric12: 'numeric12',
  GradingScale.alphabeticAF: 'alphabeticAF',
  GradingScale.none: 'none',
};
