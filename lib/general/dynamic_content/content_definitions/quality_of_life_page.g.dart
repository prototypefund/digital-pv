// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_of_life_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualityOfLifePage _$QualityOfLifePageFromJson(Map<String, dynamic> json) => QualityOfLifePage(
      intro: json['intro'] as String,
      outro: json['outro'] as String?,
      positiveQualityOfLifeExplanation: json['positive_quality_of_life_explanation'] as String,
      negativeQualityOfLifeExplanation: json['negative_quality_of_life_explanation'] as String,
      confirmationQuestion: json['confirmation_question'] as String,
      confirmActionLabel: json['confirm_action_label'] as String,
      breadcrumbTitle: json['breadcrumbTitle'] as String,
    );

Map<String, dynamic> _$QualityOfLifePageToJson(QualityOfLifePage instance) => <String, dynamic>{
      'breadcrumbTitle': instance.breadcrumbTitle,
      'intro': instance.intro,
      'positive_quality_of_life_explanation': instance.positiveQualityOfLifeExplanation,
      'negative_quality_of_life_explanation': instance.negativeQualityOfLifeExplanation,
      'confirmation_question': instance.confirmationQuestion,
      'confirm_action_label': instance.confirmActionLabel,
      'outro': instance.outro,
    };
