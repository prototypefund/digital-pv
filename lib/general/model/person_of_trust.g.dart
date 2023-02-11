// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_of_trust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonOfTrust _$PersonOfTrustFromJson(Map<String, dynamic> json) => PersonOfTrust(
      individualPowerOfAttorney: json['individualPowerOfAttorney'] as bool? ?? false,
      groupPowerOfAttorney: json['groupPowerOfAttorney'] as bool? ?? false,
      guardianship: json['guardianship'] as bool? ?? false,
    )..personalDetails = PersonalDetails.fromJson(json['personalDetails'] as Map<String, dynamic>);

Map<String, dynamic> _$PersonOfTrustToJson(PersonOfTrust instance) => <String, dynamic>{
      'guardianship': instance.guardianship,
      'individualPowerOfAttorney': instance.individualPowerOfAttorney,
      'groupPowerOfAttorney': instance.groupPowerOfAttorney,
      'personalDetails': instance.personalDetails,
    };
