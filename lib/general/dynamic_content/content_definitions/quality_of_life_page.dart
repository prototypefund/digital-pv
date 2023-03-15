import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'quality_of_life_page.g.dart';

@JsonSerializable()
class QualityOfLifePage with SerializableAsset {
  QualityOfLifePage(
      {required this.intro,
      required this.outro,
      required this.positiveQualityOfLifeExplanation,
      required this.negativeQualityOfLifeExplanation,
      required this.confirmationQuestion,
      required this.confirmActionLabel});

  factory QualityOfLifePage.fromJson(Map<String, dynamic> json) => _$QualityOfLifePageFromJson(json);

  factory QualityOfLifePage.fromCMSJson(Map<String, dynamic> attributesJson) => QualityOfLifePage(
        intro: attributesJson['intro'] as String,
        positiveQualityOfLifeExplanation: attributesJson['positive_quality_of_life_explanation'] as String,
        negativeQualityOfLifeExplanation: attributesJson['negative_quality_of_life_explanation'] as String,
        confirmationQuestion: attributesJson['confirmation_question'] as String,
        confirmActionLabel: attributesJson['confirm_action_label'] as String,
        outro: attributesJson['outro'] as String?,
      );

  final String intro;

  @JsonKey(name: 'positive_quality_of_life_explanation')
  final String positiveQualityOfLifeExplanation;

  @JsonKey(name: 'negative_quality_of_life_explanation')
  final String negativeQualityOfLifeExplanation;

  @JsonKey(name: 'confirmation_question')
  final String confirmationQuestion;

  @JsonKey(name: 'confirm_action_label')
  final String confirmActionLabel;

  final String? outro;

  @override
  Map<String, dynamic> toJson() => _$QualityOfLifePageToJson(this);
}
