import "dart:math" as math;

import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/components/contextual_help.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_goal_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/treatment_goal.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/view_components/directive_visualization/circular_quadrant_directions.dart';
import 'package:pd_app/logging.dart';
import 'package:go_router/go_router.dart';

class GeneralTreatmentObjectiveViewModel extends CreationProcessNavigationViewModel
    with Logging, CircularQuadrantDirections {
  GeneralTreatmentObjectiveViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService = getIt.get();

  final PatientDirectiveService _patientDirectiveService;

  late TreatmentGoal treatmentGoal;

  @override
  bool get nextButtonEnabled => false;

  String get intro => pageContent.intro;

  ContextualHelp get adjustArrowExplanation => pageContent.adjustArrowExplanation;

  String get summary {
    if ((_patientDirectiveService.currentPatientDirective.generalTreatmentGoal.value) >= 0) {
      return pageContent.treatmentGoalCurativeQuestion;
    } else {
      return pageContent.treatmentGoalPalliativeQuestion;
    }
  }

  String get confirmLabel => pageContent.confirmTreatmentGoalActionLabel;

  String get resetLabel => pageContent.resetArrowActionLabel;

  IconData get resetIconData => Icons.undo;

  ContextualHelp get curativeExplanation => pageContent.curativeExplanation;

  ContextualHelp get palliativeExplanation => pageContent.palliativeExplanation;

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
    _contentService.removeListener(notifyListeners);
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
    context.go(nextRoute(context).path);
  }

  void adaptTreatmentGoal(double direction) {
    // we only allow top left or top right quadrant
    // bottom left quadrant is interpreted as palliative
    // bottom right quadrant is interpreted as curative

    final double adjustedDirection;
    if (isBottomLeftQuadrant(direction)) {
      adjustedDirection = CircularQuadrantDirections.leftCenter;
    } else if (isBottomRightQuadrant(direction)) {
      adjustedDirection = CircularQuadrantDirections.rightCenter;
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

  @override
  bool get showTreatmentGoalInVisualization => true;

  TreatmentGoalPage get pageContent => _contentService.treatmentGoalPage;
}
