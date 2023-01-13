import "dart:math" as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/treatment_goal.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';

class GeneralTreatmentObjectiveViewModel extends CreationProcessNavigationViewModel with Logging {
  GeneralTreatmentObjectiveViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
  }

  final PatientDirectiveService _patientDirectiveService;

  late TreatmentGoal treatmentGoal;

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.evaluateCurrentAspects);
  }

  @override
  bool get nextButtonEnabled => false;

  String get headline => l10n.generalTreatmentGoalHeadline;

  String get changeNeedleCallToAction => l10n.generalTreatmentChangeCompassNeedleCallToAction;

  String get summary {
    if ((_patientDirectiveService.currentPatientDirective.generalTreatmentGoal?.value ?? 0) >= 0) {
      return l10n.generalTreatmentCurativeGoalQuestion;
    } else {
      return l10n.generalTreatmentPalliativeGoalQuestion;
    }
  }

  String get confirmLabel => l10n.generalTreatmentConfirm;

  String get resetLabel => l10n.generalTreatmentResetCompass;

  IconData get resetIconData => Icons.undo;

  String get curativeExplanationTitle => l10n.generalTreatmentCurativeExplanationTitle;

  String get curativeExplanation => l10n.generalTreatmentCurativeExplanation;

  String get palliativeExplanationTitle => l10n.generalTreatmentPalliativeExplanationTitle;

  String get palliativeExplanation => l10n.generalTreatmentPalliativeExplanation;

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
  }

  void resetTreatmentGoal(BuildContext context) {
    logger.d('reset treatment goal to derived value from aspects due to user request');
    _resetTreatmentGoalToValueDerivedFromAspects();
  }

  void _resetTreatmentGoalToValueDerivedFromAspects() {
    final directive = _patientDirectiveService.currentPatientDirective;

    directive.generalTreatmentGoal = TreatmentGoal(value: directive.currentAspectsScore);

    _patientDirectiveService.currentPatientDirective = directive;
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }

  @override
  void onNextButtonPressed(BuildContext context) {}

  void onConfirmPressed(BuildContext context) {
    context.go(Routes.treatmentActivities);
  }

  void adaptTreatmentGoal(double direction) {
    // we only allow top left or top right quadrant
    // bottom left quadrant is interpreted as palliative
    // bottom right quadrant is interpreted as curative

    final double adjustedDirection;
    if (math.pi / 2 < direction && direction < math.pi) {
      // bottom left quadrant
      adjustedDirection = -math.pi;
    } else if (0 < direction && direction <= math.pi / 2) {
      // bottom right quadrant
      adjustedDirection = 0;
    } else {
      adjustedDirection = direction;
    }
    final treatmentGoalValue = (adjustedDirection + math.pi / 2) / (math.pi / 2);
    logger.v(
        'adapting treatment goal to $adjustedDirection radians, resulting in a treatment goal of $treatmentGoalValue');

    final directive = _patientDirectiveService.currentPatientDirective;

    directive.generalTreatmentGoal = TreatmentGoal(value: treatmentGoalValue);

    _patientDirectiveService.currentPatientDirective = directive;
  }
}
