import "dart:math" as math;

import 'package:flutter/cupertino.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/logging.dart';

class AspectVisualizationViewModel with ChangeNotifier, Logging, RootContextL10N {
  AspectVisualizationViewModel({required this.showLabels}) : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
  }

  final PatientDirectiveService _patientDirectiveService;

  String get evaluationImageBackground => 'assets/images/placeholder.png';

  String get treatmentGoalLabel => l10n.aspectVisualizationTreatmentGoal;

  String get qualityOfLifeLabel => l10n.aspectVisualizationQualityOfLife;

  String get positiveLabel => l10n.aspectVisualizationPositive;

  String get negativeLabel => l10n.aspectVisualizationNegative;

  String get curativeLabel => l10n.aspectVisualizationCurative;

  String get palliativeLabel => l10n.aspectVisualizationPalliative;

  final bool showLabels;

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
    final treatmentGoalValue = _patientDirectiveService.currentPatientDirective.generalTreatmentGoal?.value ?? 0;
    // -1 = very palliative should become PI
    // +1 = very curative should become 0
    // 0 = equal should become PI / 2
    final rotation = math.pi / 2 * treatmentGoalValue - math.pi / 2;
    logger.v('treatment goal value is $treatmentGoalValue, resulting in rotation of $rotation rads');
    return rotation;
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
