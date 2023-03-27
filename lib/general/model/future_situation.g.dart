// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_situation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FutureSituation _$FutureSituationFromJson(Map<String, dynamic> json) => FutureSituation(
      name: json['name'] as String,
      weight: Weight.fromJson(json['weight'] as Map<String, dynamic>),
      treatmentActivitiyPreferences: (json['treatmentActivitiyPreferences'] as List<dynamic>)
          .map((e) => TreatmentActivityPreference.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FutureSituationToJson(FutureSituation instance) => <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'treatmentActivitiyPreferences': instance.treatmentActivitiyPreferences,
    };
