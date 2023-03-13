import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/components/onboarding_page.dart';
import 'package:pd_app/general/dynamic_content/json_serializable.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_config.dart';

part 'onboarding.g.dart';

@JsonSerializable()
class Onboarding with SerializableAsset {
  Onboarding(
      {required this.skipLabel, required this.pages, required this.nextButtonLabel, required this.callToActionLabel});

  factory Onboarding.fromJson(Map<String, dynamic> json) => _$OnboardingFromJson(json);

  factory Onboarding.fromCMSJson(Map<String, dynamic> attributesJson, {required CmsConfig cmsConfig}) => Onboarding(
      pages: (attributesJson['pages'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map((e) => OnboardingPage.fromCMSJson(e, cmsConfig: cmsConfig))
          .toList(),
      skipLabel: attributesJson['skip_label'] as String,
      nextButtonLabel: attributesJson['next_button_label'] as String,
      callToActionLabel: attributesJson['call_to_action_label'] as String);

  final String callToActionLabel;

  final String skipLabel;

  final String nextButtonLabel;

  final List<OnboardingPage> pages;

  @override
  Map<String, dynamic> toJson() => _$OnboardingToJson(this);
}
