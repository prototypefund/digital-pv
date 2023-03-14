import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity_choice.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'treatment_activity.g.dart';

@JsonSerializable()
class TreatmentActivity with SerializableAsset {
  TreatmentActivity({required this.activity, required this.defaultValue, required this.choices, required this.id});

  factory TreatmentActivity.fromJson(Map<String, dynamic> json) => _$TreatmentActivityFromJson(json);

  factory TreatmentActivity.fromCMSJson(Map<String, dynamic> baseJson, Map<String, dynamic> attributesJson) =>
      TreatmentActivity(
          // ignore: avoid_dynamic_calls
          choices: (attributesJson['choices']['data'] as List<dynamic>)
              .whereType<Map<String, dynamic>>()
              .map((e) => TreatmentActivityChoice.fromCMSJson(e, e['attributes'] as Map<String, dynamic>))
              .toList(),
          // ignore: avoid_dynamic_calls
          defaultValue: TreatmentActivityChoice.fromCMSJson(
              attributesJson['default_value']['data'] as Map<String, dynamic>,
              attributesJson['default_value']['data']['attributes'] as Map<String, dynamic>),
          id: baseJson['id'] as int,
          activity: attributesJson['activity'] as String);

  final String activity;

  final int id;

  final List<TreatmentActivityChoice> choices;

  @JsonKey(name: 'default_value')
  final TreatmentActivityChoice defaultValue;

  @override
  Map<String, dynamic> toJson() => _$TreatmentActivityToJson(this);
}
