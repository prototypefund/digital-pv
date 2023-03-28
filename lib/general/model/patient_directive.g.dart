// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_directive.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PatientDirectiveCWProxy {
  PatientDirective positiveAspects(List<Aspect> positiveAspects);

  PatientDirective futureSituationAspects(List<FutureSituation> futureSituationAspects);

  PatientDirective negativeAspects(List<Aspect> negativeAspects);

  PatientDirective generalTreatmentPreferences(List<TreatmentActivityPreference> generalTreatmentPreferences);

  PatientDirective personsOfTrust(List<PersonOfTrust> personsOfTrust);

  PatientDirective generalTreatmentGoal(TreatmentGoal? generalTreatmentGoal);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PatientDirective(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PatientDirective(...).copyWith(id: 12, name: "My name")
  /// ````
  PatientDirective call({
    List<Aspect>? positiveAspects,
    List<FutureSituation>? futureSituationAspects,
    List<Aspect>? negativeAspects,
    List<TreatmentActivityPreference>? generalTreatmentPreferences,
    List<PersonOfTrust>? personsOfTrust,
    TreatmentGoal? generalTreatmentGoal,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPatientDirective.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPatientDirective.copyWith.fieldName(...)`
class _$PatientDirectiveCWProxyImpl implements _$PatientDirectiveCWProxy {
  const _$PatientDirectiveCWProxyImpl(this._value);

  final PatientDirective _value;

  @override
  PatientDirective positiveAspects(List<Aspect> positiveAspects) => this(positiveAspects: positiveAspects);

  @override
  PatientDirective futureSituationAspects(List<FutureSituation> futureSituationAspects) =>
      this(futureSituationAspects: futureSituationAspects);

  @override
  PatientDirective negativeAspects(List<Aspect> negativeAspects) => this(negativeAspects: negativeAspects);

  @override
  PatientDirective generalTreatmentPreferences(List<TreatmentActivityPreference> generalTreatmentPreferences) =>
      this(generalTreatmentPreferences: generalTreatmentPreferences);

  @override
  PatientDirective personsOfTrust(List<PersonOfTrust> personsOfTrust) => this(personsOfTrust: personsOfTrust);

  @override
  PatientDirective generalTreatmentGoal(TreatmentGoal? generalTreatmentGoal) =>
      this(generalTreatmentGoal: generalTreatmentGoal);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PatientDirective(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PatientDirective(...).copyWith(id: 12, name: "My name")
  /// ````
  PatientDirective call({
    Object? positiveAspects = const $CopyWithPlaceholder(),
    Object? futureSituationAspects = const $CopyWithPlaceholder(),
    Object? negativeAspects = const $CopyWithPlaceholder(),
    Object? generalTreatmentPreferences = const $CopyWithPlaceholder(),
    Object? personsOfTrust = const $CopyWithPlaceholder(),
    Object? generalTreatmentGoal = const $CopyWithPlaceholder(),
  }) {
    return PatientDirective(
      positiveAspects: positiveAspects == const $CopyWithPlaceholder() || positiveAspects == null
          ? _value.positiveAspects
          // ignore: cast_nullable_to_non_nullable
          : positiveAspects as List<Aspect>,
      futureSituationAspects: futureSituationAspects == const $CopyWithPlaceholder() || futureSituationAspects == null
          ? _value.futureSituationAspects
          // ignore: cast_nullable_to_non_nullable
          : futureSituationAspects as List<FutureSituation>,
      negativeAspects: negativeAspects == const $CopyWithPlaceholder() || negativeAspects == null
          ? _value.negativeAspects
          // ignore: cast_nullable_to_non_nullable
          : negativeAspects as List<Aspect>,
      generalTreatmentPreferences:
          generalTreatmentPreferences == const $CopyWithPlaceholder() || generalTreatmentPreferences == null
              ? _value.generalTreatmentPreferences
              // ignore: cast_nullable_to_non_nullable
              : generalTreatmentPreferences as List<TreatmentActivityPreference>,
      personsOfTrust: personsOfTrust == const $CopyWithPlaceholder() || personsOfTrust == null
          ? _value.personsOfTrust
          // ignore: cast_nullable_to_non_nullable
          : personsOfTrust as List<PersonOfTrust>,
      generalTreatmentGoal: generalTreatmentGoal == const $CopyWithPlaceholder()
          ? _value.generalTreatmentGoal
          // ignore: cast_nullable_to_non_nullable
          : generalTreatmentGoal as TreatmentGoal?,
    );
  }
}

extension $PatientDirectiveCopyWith on PatientDirective {
  /// Returns a callable class that can be used as follows: `instanceOfPatientDirective.copyWith(...)` or like so:`instanceOfPatientDirective.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PatientDirectiveCWProxy get copyWith => _$PatientDirectiveCWProxyImpl(this);
}

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
