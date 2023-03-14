// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_activity_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentActivityPreference _$TreatmentActivityPreferenceFromJson(Map<String, dynamic> json) =>
    TreatmentActivityPreference(
      activity: json['activity'] as String,
      choice: json['choice'] as String,
      activityId: json['activityId'] as int?,
      choiceId: json['choiceId'] as int?,
    );

Map<String, dynamic> _$TreatmentActivityPreferenceToJson(TreatmentActivityPreference instance) => <String, dynamic>{
      'activity': instance.activity,
      'choice': instance.choice,
      'activityId': instance.activityId,
      'choiceId': instance.choiceId,
    };
