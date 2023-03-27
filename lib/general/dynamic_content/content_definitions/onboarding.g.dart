// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Onboarding _$OnboardingFromJson(Map<String, dynamic> json) => Onboarding(
      skipLabel: json['skipLabel'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => OnboardingPage.fromJson(e as Map<String, dynamic>)).toList(),
      nextButtonLabel: json['nextButtonLabel'] as String,
      callToActionLabel: json['callToActionLabel'] as String,
    );

Map<String, dynamic> _$OnboardingToJson(Onboarding instance) => <String, dynamic>{
      'callToActionLabel': instance.callToActionLabel,
      'skipLabel': instance.skipLabel,
      'nextButtonLabel': instance.nextButtonLabel,
      'pages': instance.pages,
    };
