// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_directive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientDirective _$PatientDirectiveFromJson(Map<String, dynamic> json) => PatientDirective(
      positiveAspects:
          (json['positiveAspects'] as List<dynamic>).map((e) => Aspect.fromJson(e as Map<String, dynamic>)).toList(),
      futureSituationAspects: (json['futureSituationAspects'] as List<dynamic>)
          .map((e) => FutureSituation.fromJson(e as Map<String, dynamic>))
          .toList(),
      negativeAspects:
          (json['negativeAspects'] as List<dynamic>).map((e) => Aspect.fromJson(e as Map<String, dynamic>)).toList(),
      generalTreatmentPreferences: (json['generalTreatmentPreferences'] as List<dynamic>)
          .map((e) => TreatmentActivityPreference.fromJson(e as Map<String, dynamic>))
          .toList(),
      personsOfTrust: (json['personsOfTrust'] as List<dynamic>?)
              ?.map((e) => PersonOfTrust.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      generalTreatmentGoal: json['generalTreatmentGoal'] == null
          ? null
          : TreatmentGoal.fromJson(json['generalTreatmentGoal'] as Map<String, dynamic>),
    )..personalDetails = PersonalDetails.fromJson(json['personalDetails'] as Map<String, dynamic>);

Map<String, dynamic> _$PatientDirectiveToJson(PatientDirective instance) => <String, dynamic>{
      'positiveAspects': instance.positiveAspects,
      'negativeAspects': instance.negativeAspects,
      'futureSituationAspects': instance.futureSituationAspects,
      'generalTreatmentPreferences': instance.generalTreatmentPreferences,
      'personsOfTrust': instance.personsOfTrust,
      'personalDetails': instance.personalDetails,
      'generalTreatmentGoal': instance.generalTreatmentGoal,
    };
