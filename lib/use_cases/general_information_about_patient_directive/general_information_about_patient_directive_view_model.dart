import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';

class GeneralInformationAboutPatientDirectiveViewModel extends CreationProcessNavigationViewModel {
  GeneralInformationAboutPatientDirectiveViewModel() {
    _loadContentMarkdown();
  }

  String _contentMarkdown = "";

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.trustedThirdParty);
  }

  @override
  void onNextButtonPressed(BuildContext context) {}

  Future<void> _loadContentMarkdown() async {
    _contentMarkdown = await rootBundle.loadString(l10n.generalInfoMarkdownLocation);
    notifyListeners();
  }

  String get contentMarkdown => _contentMarkdown;

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
