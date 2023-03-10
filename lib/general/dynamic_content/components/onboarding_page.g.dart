// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingPage _$OnboardingPageFromJson(Map<String, dynamic> json) => OnboardingPage(
      content: json['content'] as String,
      logo: json['logo'] == null ? null : CmsImage.fromJson(json['logo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OnboardingPageToJson(OnboardingPage instance) => <String, dynamic>{
      'content': instance.content,
      'logo': instance.logo,
    };
