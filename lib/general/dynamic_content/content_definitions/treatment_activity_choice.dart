import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'treatment_activity_choice.g.dart';

@JsonSerializable()
class TreatmentActivityChoice with SerializableAsset {
  TreatmentActivityChoice({required this.choice, required this.id});

  factory TreatmentActivityChoice.fromJson(Map<String, dynamic> json) => _$TreatmentActivityChoiceFromJson(json);

  factory TreatmentActivityChoice.fromCMSJson(Map<String, dynamic> baseJson, Map<String, dynamic> attributesJson) =>
      TreatmentActivityChoice(choice: attributesJson['choice'] as String, id: baseJson['id'] as int);

  final String choice;

  final int id;

  @override
  Map<String, dynamic> toJson() => _$TreatmentActivityChoiceToJson(this);
}
