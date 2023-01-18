import 'package:collection/collection.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/model/treatment_goal.dart';

class PatientDirective {
  PatientDirective(
      {required this.positiveAspects,
      required this.futureSituationAspects,
      required this.negativeAspects,
      TreatmentGoal? generalTreatmentGoal})
      : _generalTreatmentGoal = generalTreatmentGoal;

  final List<Aspect> positiveAspects;
  final List<Aspect> negativeAspects;
  final List<FutureSituation> futureSituationAspects;

  TreatmentGoal? _generalTreatmentGoal;

  TreatmentActivityChoice generalHospitalizationPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice generalIntensiveTreatmentPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice generalResuscitationPreference = TreatmentActivityChoice.notSpecified;

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
}
