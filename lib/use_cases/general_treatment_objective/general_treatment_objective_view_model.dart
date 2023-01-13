import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';

class GeneralTreatmentObjectiveViewModel extends CreationProcessNavigationViewModel {
  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.evaluateCurrentAspects);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.treatmentActivities);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;
}
