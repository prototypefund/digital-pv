import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/markdown/local_markdown_content_loading.dart';
import 'package:pd_app/general/navigation/routes.dart';

class GeneralInformationAboutPatientDirectiveViewModel extends CreationProcessNavigationViewModel
    with LocalMarkdownContentLoading {
  GeneralInformationAboutPatientDirectiveViewModel() {
    loadContentMarkdown(l10n.generalInfoMarkdownLocation);
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.trustedThirdParty);
  }

  @override
  void onNextButtonPressed(BuildContext context) {}

  String get contentMarkdown => cachedMarkdownContent(l10n.generalInfoMarkdownLocation);

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => true;

  @override
  bool get nextButtonEnabled => false;

  void onConfirmPressed(BuildContext context) {
    context.go(Routes.personalDetails);
  }

  String get confirmLabel => l10n.generalInfoConfirm;
}
