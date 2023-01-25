// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_situation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FutureSituation _$FutureSituationFromJson(Map<String, dynamic> json) => FutureSituation(
      name: json['name'] as String,
      weight: Weight.fromJson(json['weight'] as Map<String, dynamic>),
      hospitalizationPreference:
          $enumDecodeNullable(_$TreatmentActivityChoiceEnumMap, json['hospitalizationPreference']) ??
              TreatmentActivityChoice.notSpecified,
      intensiveTreatmentPreference:
          $enumDecodeNullable(_$TreatmentActivityChoiceEnumMap, json['intensiveTreatmentPreference']) ??
              TreatmentActivityChoice.notSpecified,
      resuscitationPreference: $enumDecodeNullable(_$TreatmentActivityChoiceEnumMap, json['resuscitationPreference']) ??
          TreatmentActivityChoice.notSpecified,
    );

Map<String, dynamic> _$FutureSituationToJson(FutureSituation instance) => <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'hospitalizationPreference': _$TreatmentActivityChoiceEnumMap[instance.hospitalizationPreference]!,
      'intensiveTreatmentPreference': _$TreatmentActivityChoiceEnumMap[instance.intensiveTreatmentPreference]!,
      'resuscitationPreference': _$TreatmentActivityChoiceEnumMap[instance.resuscitationPreference]!,
    };

const _$TreatmentActivityChoiceEnumMap = {
  TreatmentActivityChoice.notSpecified: 'notSpecified',
  TreatmentActivityChoice.no: 'no',
  TreatmentActivityChoice.yes: 'yes',
  TreatmentActivityChoice.symptomControl: 'symptomControl',
};
