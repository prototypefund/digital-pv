import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/aspect_with_simulation.dart';
import 'package:pd_app/general/model/treatment_activity_preference.dart';
import 'package:pd_app/general/model/weight.dart';

part 'future_situation.g.dart';

@JsonSerializable()
@CopyWith()
class FutureSituation extends Aspect with AspectWithSimulation {
  FutureSituation(
      {required super.name,
      required super.weight,
      required this.treatmentActivitiyPreferences,
      bool simulateAspect = false})
      : _simulateAspect = simulateAspect;

  factory FutureSituation.fromJson(Map<String, dynamic> json) => _$FutureSituationFromJson(json);

  List<TreatmentActivityPreference> treatmentActivitiyPreferences;

  final bool _simulateAspect;

  @override
  bool get simulateAspect => _simulateAspect;

  @override
  Map<String, dynamic> toJson() => _$FutureSituationToJson(this);
}
