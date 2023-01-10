import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/model/treatment_goal.dart';

class PatientDirective {
  PatientDirective(
      {required this.positiveAspects,
      required this.futureSituationAspects,
      required this.negativeAspects,
      required this.generalTreatmentGoal});

  final List<Aspect> positiveAspects;
  final List<Aspect> negativeAspects;
  final List<FutureSituation> futureSituationAspects;

  final TreatmentGoal generalTreatmentGoal;

  TreatmentActivityChoice generalHospitalizationPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice generalIntensiveTreatmentPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice generalResuscitationPreference = TreatmentActivityChoice.notSpecified;

  ///
  /// returns the score of all current aspects, normalized to -1 and 1.
  /// 1 means all positive, -1 means all negative
  /// 0 if no aspects are defined
  double get currentAspectsScore {
    final double negativeWeights =
        negativeAspects.map((e) => e.weight.value).fold(0, (previousValue, newValue) => previousValue + newValue);
    final double positiveWeights =
        positiveAspects.map((e) => e.weight.value).fold(0, (previousValue, newValue) => previousValue + newValue);

    final sumWeights = negativeWeights + positiveWeights;

    if (sumWeights == 0) {
      return 0;
    }

    final normalizedPositive = positiveWeights / sumWeights;
    final normalizedNegative = negativeWeights / sumWeights;

    return normalizedPositive - normalizedNegative;
  }
}
