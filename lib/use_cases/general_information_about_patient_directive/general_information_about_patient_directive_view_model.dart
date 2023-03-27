import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/general_information_about_directive_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';

class GeneralInformationAboutPatientDirectiveViewModel extends CreationProcessNavigationViewModel {
  GeneralInformationAboutPatientDirectiveViewModel() {
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService = getIt.get();

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.trustedThirdParty);
  }

  @override
  void onNextButtonPressed(BuildContext context) {}

  GeneralInformationAboutDirectivePage get pageContent => _contentService.generalInformationAboutDirectivePage;

  String get contentMarkdown => pageContent.intro;

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => true;

  @override
  bool get nextButtonEnabled => false;

  void onConfirmPressed(BuildContext context) {
    context.go(Routes.personalDetails);
  }

  String get confirmLabel => pageContent.confirmActionLabel;

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }
}
