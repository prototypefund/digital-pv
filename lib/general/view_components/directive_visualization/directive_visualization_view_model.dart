import "dart:math" as math;

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/logging.dart';

class DirectiveVisualizationViewModel with ChangeNotifier, Logging, RootContextL10N {
  DirectiveVisualizationViewModel(
      {required this.showLabels, required this.showTreatmentGoal, required this.simulateFutureAspects})
      : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
  }

  final PatientDirectiveService _patientDirectiveService;

  final bool showLabels;

  final bool showTreatmentGoal;

  final bool simulateFutureAspects;

  String get evaluationImageBackground => 'assets/images/compass.svg';

  String get treatmentGoalLabel => l10n.aspectVisualizationTreatmentGoal;

  String get qualityOfLifeLabel => l10n.aspectVisualizationQualityOfLife;

  String get positiveLabel => l10n.aspectVisualizationPositive;

  String get negativeLabel => l10n.aspectVisualizationNegative;

  String get curativeLabel => l10n.aspectVisualizationCurative;

  String get palliativeLabel => l10n.aspectVisualizationPalliative;

  List<Aspect> get positiveAspects => _patientDirectiveService.currentPatientDirective.positiveAspects;

  List<Aspect> get negativeAspects => _patientDirectiveService.currentPatientDirective.negativeAspects;

  List<Aspect> get futureAspects => _patientDirectiveService.currentPatientDirective.futureSituationAspects;

  /// aspect evaluation arrow rotation in radians
  /// by default the arrow is pointing to the right (very negative)
  /// rotating by PI means pointing to the left (very positive)
  ///
  double get aspectEvaluationArrowRotation {
    final aspectScore = _patientDirectiveService.currentPatientDirective.currentAspectsScore;
    // -1 = very negative should become 0
    // +1 = very positive should become PI
    // 0 = equal should become PI / 2
    final rotation = math.pi / 2 * aspectScore + math.pi / 2;

    logger.v('aspect score is $aspectScore, resulting in rotation of $rotation rads');
    return rotation;
  }

  /// treatment goal arrow rotation in radians
  /// by default the arrow is pointing to the right (completely palliative)
  /// rotating by PI means pointing to the left (completely curative)
  ///
  double get treatmentGoalArrowRotation {
    final double treatmentGoalValue;
    if (simulateFutureAspects) {
      treatmentGoalValue = _patientDirectiveService.currentPatientDirective.simulatedGeneralTreatmentGoal.value;
    } else {
      treatmentGoalValue = _patientDirectiveService.currentPatientDirective.generalTreatmentGoal.value;
    }
    // -1 = very palliative should become PI
    // +1 = very curative should become 0
    // 0 = equal should become PI / 2
    final rotation = math.pi / 2 * treatmentGoalValue - math.pi / 2;
    logger.v('treatment goal value is $treatmentGoalValue, resulting in rotation of $rotation rads');
    return rotation;
  }

  void onFutureAspectTapped(BuildContext context, FutureSituation aspect) {
    context.go(Routes.buildShowFutureSituationsRoute(highlightedSituation: aspect));
  }

  void onPositiveAspectTapped(BuildContext context, Aspect aspect) {
    context.go(Routes.buildShowPositiveAspectRoute(highlightedSituation: aspect));
  }

  void onNegativeAspectTapped(BuildContext context, Aspect aspect) {
    context.go(Routes.buildShowNegativeAspectRoute(highlightedSituation: aspect));
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }
}
