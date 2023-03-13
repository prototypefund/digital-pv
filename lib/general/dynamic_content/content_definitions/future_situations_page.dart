import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/components/add_aspect_widget.dart';
import 'package:pd_app/general/dynamic_content/components/aspect_list_widget.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'future_situations_page.g.dart';

@JsonSerializable()
class FutureSituationsPage with SerializableAsset {
  FutureSituationsPage(
      {required this.intro,
      required this.examplesTitle,
      required this.aspectListWidget,
      required this.outro,
      required this.locale,
      required this.addAspectWidget});

  factory FutureSituationsPage.fromJson(Map<String, dynamic> json) => _$FutureSituationsPageFromJson(json);

  factory FutureSituationsPage.fromCMSJson(Map<String, dynamic> attributesJson) => FutureSituationsPage(
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
  Map<String, dynamic> toJson() => _$FutureSituationsPageToJson(this);
}
