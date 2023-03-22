// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentActivity _$TreatmentActivityFromJson(Map<String, dynamic> json) => TreatmentActivity(
      activity: json['activity'] as String,
      defaultValue: TreatmentActivityChoice.fromJson(json['default_value'] as Map<String, dynamic>),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => TreatmentActivityChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
    );

Map<String, dynamic> _$TreatmentActivityToJson(TreatmentActivity instance) => <String, dynamic>{
      'activity': instance.activity,
      'id': instance.id,
      'choices': instance.choices,
      'default_value': instance.defaultValue,
    };
