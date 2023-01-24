import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/treatment_activity.dart';

part 'future_situation.g.dart';

@JsonSerializable()
class FutureSituation extends Aspect {
  FutureSituation(
      {required super.name,
      required super.weight,
      this.hospitalizationPreference = TreatmentActivityChoice.notSpecified,
      this.intensiveTreatmentPreference = TreatmentActivityChoice.notSpecified,
      this.resuscitationPreference = TreatmentActivityChoice.notSpecified});

  factory FutureSituation.fromJson(Map<String, dynamic> json) => _$FutureSituationFromJson(json);

  TreatmentActivityChoice hospitalizationPreference;
  TreatmentActivityChoice intensiveTreatmentPreference;
  TreatmentActivityChoice resuscitationPreference;

  Map<String, dynamic> toJson() => _$FutureSituationToJson(this);
}
