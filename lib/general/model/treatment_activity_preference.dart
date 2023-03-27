import 'package:json_annotation/json_annotation.dart';

part 'treatment_activity_preference.g.dart';

@JsonSerializable()
class TreatmentActivityPreference {
  TreatmentActivityPreference(
      {required this.activity, required this.choice, required this.activityId, required this.choiceId});

  factory TreatmentActivityPreference.fromJson(Map<String, dynamic> json) =>
      _$TreatmentActivityPreferenceFromJson(json);

  final String activity;
  final String choice;
  final int? activityId;
  final int? choiceId;

  Map<String, dynamic> toJson() => _$TreatmentActivityPreferenceToJson(this);
}
