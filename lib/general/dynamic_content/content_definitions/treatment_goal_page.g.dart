// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_goal_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentGoalPage _$TreatmentGoalPageFromJson(Map<String, dynamic> json) => TreatmentGoalPage(
      treatmentGoalCurativeQuestion: json['treatment_goal_curative_confirmation_question'] as String,
      treatmentGoalPalliativeQuestion: json['treatment_goal_palliative_confirmation_question'] as String,
      adjustArrowExplanation: ContextualHelp.fromJson(json['adjust_arrow_explanation'] as Map<String, dynamic>),
      resetArrowActionLabel: json['reset_arrow_action_label'] as String,
      curativeExplanation: ContextualHelp.fromJson(json['curative_explanation'] as Map<String, dynamic>),
      palliativeExplanation: ContextualHelp.fromJson(json['palliative_explanation'] as Map<String, dynamic>),
      confirmTreatmentGoalActionLabel: json['confirm_treatment_goal_action_label'] as String,
      intro: json['intro'] as String,
    );

Map<String, dynamic> _$TreatmentGoalPageToJson(TreatmentGoalPage instance) => <String, dynamic>{
      'intro': instance.intro,
      'treatment_goal_curative_confirmation_question': instance.treatmentGoalCurativeQuestion,
      'treatment_goal_palliative_confirmation_question': instance.treatmentGoalPalliativeQuestion,
      'adjust_arrow_explanation': instance.adjustArrowExplanation,
      'reset_arrow_action_label': instance.resetArrowActionLabel,
      'curative_explanation': instance.curativeExplanation,
      'palliative_explanation': instance.palliativeExplanation,
      'confirm_treatment_goal_action_label': instance.confirmTreatmentGoalActionLabel,
    };
