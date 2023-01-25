import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

abstract class CreationProcessNavigationViewModel with RootContextL10N, ChangeNotifier {
  String get nextButtonText => l10n.navigationNext;

  String get backButtonText => l10n.navigationBack;

  bool get nextButtonShowArrow => true;

  void onBackButtonPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
    }
  }

  void onNextButtonPressed(BuildContext context);

  bool get backButtonEnabled => true;

  bool get nextButtonEnabled => true;

  bool get nextButtonVisible => true;

  bool get backButtonVisible => true;

  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization;

  bool get showFloatingAspectVisualizationIfSpaceAvailable => false;

  bool get showTreatmentGoalInVisualization;
}
