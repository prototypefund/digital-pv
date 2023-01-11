import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';

class PersonalDetailsViewModel extends CreationProcessNavigationViewModel {
  @override
  bool get nextButtonEnabled => false;

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.generalInformationAboutPatientDirective);
  }

  @override
  void onNextButtonPressed(BuildContext context) {}

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;
}
