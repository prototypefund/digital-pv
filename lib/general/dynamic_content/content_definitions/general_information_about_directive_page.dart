import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'general_information_about_directive_page.g.dart';

@JsonSerializable()
class GeneralInformationAboutDirectivePage with SerializableAsset {
  GeneralInformationAboutDirectivePage(
      {required this.breadcrumbTitle, required this.intro, required this.confirmActionLabel});

  factory GeneralInformationAboutDirectivePage.fromJson(Map<String, dynamic> json) =>
      _$GeneralInformationAboutDirectivePageFromJson(json);

  factory GeneralInformationAboutDirectivePage.fromCMSJson(Map<String, dynamic> attributesJson) =>
      GeneralInformationAboutDirectivePage(
        breadcrumbTitle: attributesJson['breadcrumb_title'] as String,
        intro: attributesJson['intro'] as String,
        confirmActionLabel: attributesJson['confirm_action_label'] as String,
      );

  final String intro;

  final String breadcrumbTitle;

  @JsonKey(name: 'confirm_action_label')
  final String confirmActionLabel;

  @override
  Map<String, dynamic> toJson() => _$GeneralInformationAboutDirectivePageToJson(this);
}
