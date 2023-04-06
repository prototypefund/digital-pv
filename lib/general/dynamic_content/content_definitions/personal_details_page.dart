import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'personal_details_page.g.dart';

@JsonSerializable()
class PersonalDetailsPage with SerializableAsset {
  PersonalDetailsPage(
      {required this.breadcrumbTitle,
      required this.intro,
      required this.downloadAsPdfActionLabel,
      required this.showDirectiveActionLabel});

  factory PersonalDetailsPage.fromJson(Map<String, dynamic> json) => _$PersonalDetailsPageFromJson(json);

  factory PersonalDetailsPage.fromCMSJson(Map<String, dynamic> attributesJson) => PersonalDetailsPage(
        breadcrumbTitle: attributesJson['breadcrumb_title'] as String,
        intro: attributesJson['intro'] as String,
        downloadAsPdfActionLabel: attributesJson['download_as_pdf_action_label'] as String,
        showDirectiveActionLabel: attributesJson['show_directive_action_label'] as String,
      );

  final String breadcrumbTitle;

  final String intro;

  @JsonKey(name: 'download_as_pdf_action_label')
  final String downloadAsPdfActionLabel;

  @JsonKey(name: 'show_directive_action_label')
  final String showDirectiveActionLabel;

  @override
  Map<String, dynamic> toJson() => _$PersonalDetailsPageToJson(this);
}
