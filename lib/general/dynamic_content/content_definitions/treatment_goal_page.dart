import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/components/contextual_help.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'treatment_goal_page.g.dart';

@JsonSerializable()
class TreatmentGoalPage with SerializableAsset {
  TreatmentGoalPage(
      {required this.treatmentGoalCurativeQuestion,
      required this.treatmentGoalPalliativeQuestion,
      required this.adjustArrowExplanation,
      required this.resetArrowActionLabel,
      required this.curativeExplanation,
      required this.palliativeExplanation,
      required this.confirmTreatmentGoalActionLabel,
      required this.intro});

  factory TreatmentGoalPage.fromJson(Map<String, dynamic> json) => _$TreatmentGoalPageFromJson(json);

  factory TreatmentGoalPage.fromCMSJson(Map<String, dynamic> attributesJson) => TreatmentGoalPage(
      intro: attributesJson['intro'] as String,
      treatmentGoalCurativeQuestion: attributesJson['treatment_goal_curative_confirmation_question'] as String,
      treatmentGoalPalliativeQuestion: attributesJson['treatment_goal_palliative_confirmation_question'] as String,
      adjustArrowExplanation:
          ContextualHelp.fromJson(attributesJson['adjust_arrow_explanation'] as Map<String, dynamic>),
      resetArrowActionLabel: attributesJson['reset_arrow_action_label'] as String,
      palliativeExplanation: ContextualHelp.fromJson(attributesJson['palliative_explanation'] as Map<String, dynamic>),
      curativeExplanation: ContextualHelp.fromJson(attributesJson['curative_explanation'] as Map<String, dynamic>),
      confirmTreatmentGoalActionLabel: attributesJson['confirm_treatment_goal_action_label'] as String);

  final String intro;

  @JsonKey(name: 'treatment_goal_curative_confirmation_question')
  final String treatmentGoalCurativeQuestion;

  @JsonKey(name: 'treatment_goal_palliative_confirmation_question')
  final String treatmentGoalPalliativeQuestion;

  @JsonKey(name: 'adjust_arrow_explanation')
  final ContextualHelp adjustArrowExplanation;

  @JsonKey(name: 'reset_arrow_action_label')
  final String resetArrowActionLabel;

  @JsonKey(name: 'curative_explanation')
  final ContextualHelp curativeExplanation;

  @JsonKey(name: 'palliative_explanation')
  final ContextualHelp palliativeExplanation;

  @JsonKey(name: "confirm_treatment_goal_action_label")
  final String confirmTreatmentGoalActionLabel;

  @override
  Map<String, dynamic> toJson() => _$TreatmentGoalPageToJson(this);
}
