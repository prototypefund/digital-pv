import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/treatment_activity_preference.dart';
import 'package:pd_app/general/model/weight.dart';

part 'future_situation.g.dart';

@JsonSerializable()
class FutureSituation extends Aspect {
  FutureSituation({required super.name, required super.weight, required this.treatmentActivitiyPreferences});

  factory FutureSituation.fromJson(Map<String, dynamic> json) => _$FutureSituationFromJson(json);

  List<TreatmentActivityPreference> treatmentActivitiyPreferences;

  @override
  Map<String, dynamic> toJson() => _$FutureSituationToJson(this);
}
