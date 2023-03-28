import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/components/add_aspect_widget.dart';
import 'package:pd_app/general/dynamic_content/components/aspect_list_widget.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'negative_aspects_page.g.dart';

@JsonSerializable()
class NegativeAspectsPage with SerializableAsset {
  NegativeAspectsPage(
      {required this.intro,
      required this.examplesTitle,
      required this.aspectListWidget,
      required this.outro,
      required this.locale,
      required this.addAspectWidget});

  factory NegativeAspectsPage.fromJson(Map<String, dynamic> json) => _$NegativeAspectsPageFromJson(json);

  factory NegativeAspectsPage.fromCMSJson(Map<String, dynamic> attributesJson) => NegativeAspectsPage(
      intro: attributesJson['intro'] as String?,
      outro: attributesJson['outro'] as String?,
      examplesTitle: attributesJson['examples_title'] as String,
      aspectListWidget: AspectListWidget.fromJson(attributesJson['aspect_list_widget'] as Map<String, dynamic>),
      addAspectWidget: AddAspectWidget.fromJson(attributesJson['add_aspect_widget'] as Map<String, dynamic>),
      locale: attributesJson['locale'] as String);

  final String locale;

  final String? intro;

  final AspectListWidget aspectListWidget;

  final AddAspectWidget addAspectWidget;

  final String? outro;

  @JsonKey(name: "examples_title")
  final String examplesTitle;

  @override
  Map<String, dynamic> toJson() => _$NegativeAspectsPageToJson(this);
}