import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'treatment_activities_page.g.dart';

@JsonSerializable()
class TreatmentActivitiesPage with SerializableAsset {
  TreatmentActivitiesPage({required this.intro, required this.outro, required this.treatmentActivitiesTitle});

  factory TreatmentActivitiesPage.fromJson(Map<String, dynamic> json) => _$TreatmentActivitiesPageFromJson(json);

  factory TreatmentActivitiesPage.fromCMSJson(Map<String, dynamic> attributesJson) => TreatmentActivitiesPage(
        intro: attributesJson['intro'] as String,
        outro: attributesJson['outro'] as String?,
        treatmentActivitiesTitle: attributesJson['treatment_activities_title'] as String,
      );

  final String intro;

  final String? outro;

  @JsonKey(name: "treatment_activities_title")
  final String treatmentActivitiesTitle;

  @override
  Map<String, dynamic> toJson() => _$TreatmentActivitiesPageToJson(this);
}
