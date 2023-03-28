import 'package:collection/collection.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/person_of_trust.dart';
import 'package:pd_app/general/model/personal_details.dart';
import 'package:pd_app/general/model/treatment_activity_preference.dart';
import 'package:pd_app/general/model/treatment_goal.dart';

part 'patient_directive.g.dart';

@JsonSerializable()
@CopyWith()
class PatientDirective {
  PatientDirective(
      {required this.positiveAspects,
      required this.futureSituationAspects,
      required this.negativeAspects,
      required this.generalTreatmentPreferences,
      this.personsOfTrust = const [],
      TreatmentGoal? generalTreatmentGoal})
      : _generalTreatmentGoal = generalTreatmentGoal;

  factory PatientDirective.fromJson(Map<String, dynamic> json) => _$PatientDirectiveFromJson(json);

  final List<Aspect> positiveAspects;
  final List<Aspect> negativeAspects;
  final List<FutureSituation> futureSituationAspects;

  TreatmentGoal? _generalTreatmentGoal;

  List<TreatmentActivityPreference> generalTreatmentPreferences;

  List<PersonOfTrust> personsOfTrust;

  PersonalDetails personalDetails = PersonalDetails();

  TreatmentGoal get generalTreatmentGoal {
    return _generalTreatmentGoal ?? TreatmentGoal(value: currentAspectsScore);
  }

  set generalTreatmentGoal(TreatmentGoal newValue) {
    _generalTreatmentGoal = newValue;
  }

  ///
  /// returns the score of all current aspects, normalized to -1 and 1.
  /// 1 means all positive, -1 means all negative
  /// 0 if no aspects are defined
  double get currentAspectsScore {
    final negativeWeights = negativeAspects.map((e) => e.weight.value).sum;

    final double positiveWeights = positiveAspects.map((e) => e.weight.value).sum;

    final sumWeights = negativeWeights + positiveWeights;

    if (sumWeights == 0) {
      return 0;
    }

    final normalizedPositive = positiveWeights / sumWeights;
    final normalizedNegative = negativeWeights / sumWeights;

    return normalizedPositive - normalizedNegative;
  }

  Map<String, dynamic> toJson() => _$PatientDirectiveToJson(this);
}
