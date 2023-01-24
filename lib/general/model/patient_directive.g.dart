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
      personsOfTrust: (json['personsOfTrust'] as List<dynamic>?)
              ?.map((e) => PersonOfTrust.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      generalTreatmentGoal: json['generalTreatmentGoal'] == null
          ? null
          : TreatmentGoal.fromJson(json['generalTreatmentGoal'] as Map<String, dynamic>),
    )
      ..generalHospitalizationPreference =
          $enumDecode(_$TreatmentActivityChoiceEnumMap, json['generalHospitalizationPreference'])
      ..generalIntensiveTreatmentPreference =
          $enumDecode(_$TreatmentActivityChoiceEnumMap, json['generalIntensiveTreatmentPreference'])
      ..generalResuscitationPreference =
          $enumDecode(_$TreatmentActivityChoiceEnumMap, json['generalResuscitationPreference'])
      ..personalDetails = PersonalDetails.fromJson(json['personalDetails'] as Map<String, dynamic>);

Map<String, dynamic> _$PatientDirectiveToJson(PatientDirective instance) => <String, dynamic>{
      'positiveAspects': instance.positiveAspects,
      'negativeAspects': instance.negativeAspects,
      'futureSituationAspects': instance.futureSituationAspects,
      'generalHospitalizationPreference': _$TreatmentActivityChoiceEnumMap[instance.generalHospitalizationPreference]!,
      'generalIntensiveTreatmentPreference':
          _$TreatmentActivityChoiceEnumMap[instance.generalIntensiveTreatmentPreference]!,
      'generalResuscitationPreference': _$TreatmentActivityChoiceEnumMap[instance.generalResuscitationPreference]!,
      'personsOfTrust': instance.personsOfTrust,
      'personalDetails': instance.personalDetails,
      'generalTreatmentGoal': instance.generalTreatmentGoal,
    };

const _$TreatmentActivityChoiceEnumMap = {
  TreatmentActivityChoice.notSpecified: 'notSpecified',
  TreatmentActivityChoice.no: 'no',
  TreatmentActivityChoice.yes: 'yes',
  TreatmentActivityChoice.symptomControl: 'symptomControl',
};
