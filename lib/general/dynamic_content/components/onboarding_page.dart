import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/components/cms_image.dart';
import 'package:pd_app/general/dynamic_content/json_serializable.dart';

part 'onboarding_page.g.dart';

@JsonSerializable()
class OnboardingPage with SerializableAsset {
  OnboardingPage({required this.content, required this.logo});

  factory OnboardingPage.fromJson(Map<String, dynamic> json) => _$OnboardingPageFromJson(json);

  factory OnboardingPage.fromCMSJson(Map<String, dynamic> attributesJson) => OnboardingPage(
      content: attributesJson['content'] as String,
      logo: CmsImage.fromCMSJson(attributesJson['logo'] as Map<String, dynamic>));

  final String content;

  final CmsImage? logo;

  @override
  Map<String, dynamic> toJson() => _$OnboardingPageToJson(this);
}
