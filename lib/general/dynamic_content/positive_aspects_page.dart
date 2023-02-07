import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/json_serializable.dart';

part 'positive_aspects_page.g.dart';

@JsonSerializable()
class PositiveAspectsPage with SerializableAsset {
  PositiveAspectsPage({required this.intro, required this.outro, required this.locale});

  factory PositiveAspectsPage.fromJson(Map<String, dynamic> json) => _$PositiveAspectsPageFromJson(json);

  factory PositiveAspectsPage.fromCMSJson(Map<String, dynamic> attributesJson) => PositiveAspectsPage(
      intro: attributesJson['intro'] as String?,
      outro: attributesJson['outro'] as String?,
      locale: attributesJson['locale'] as String);

  final String locale;

  final String? intro;

  final String? outro;

  @override
  Map<String, dynamic> toJson() => _$PositiveAspectsPageToJson(this);
}
