import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/asset_path_correction.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/markdown/local_markdown_content_loading.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/personal_details/personal_data_for_directive_view_model.dart';

class PersonalDetailsViewModel extends CreationProcessNavigationViewModel
    with AssetPathCorrection, LocalMarkdownContentLoading, Logging {
  PersonalDetailsViewModel() : _patientDirectiveService = getIt.get() {
    personalDetailsFormViewModel = PersonalDataForDirectiveViewModel(
        personalDetails: _patientDirectiveService.currentPatientDirective.personalDetails);
    loadContentMarkdown(l10n.personalDetailsForDirectiveIntroductionMarkdownPath);
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
    personalDetailsFormViewModel.addListener(_reactToPersonalDetailsChange);
  }

  late PersonalDetailsFormViewModel personalDetailsFormViewModel;

  final PatientDirectiveService _patientDirectiveService;

  @override
  bool get nextButtonEnabled => personalDetailsFormViewModel.isInputValid();

  @override
  bool get nextButtonShowArrow => false;

  @override
  String get nextButtonText => l10n.personalDetailsForDirectiveDownloadDirective;

  String get introductionMarkdownContent =>
      cachedMarkdownContent(l10n.personalDetailsForDirectiveIntroductionMarkdownPath);

  VoidCallback? downloadDirectiveAction(BuildContext context) {
    if (personalDetailsFormViewModel.isInputValid()) {
      return () => onDownloadDirectivePressed(context);
    } else {
      return null;
    }
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.generalInformationAboutPatientDirective);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    onDownloadDirectivePressed(context);
  }

  @override
  bool get nextButtonVisible => true;

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showTreatmentGoalInVisualization => true;

  String get downloadDirectiveLabel => l10n.personalDetailsForDirectiveDownloadDirective;

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }

  void _reactToPersonalDetailsChange() {
    notifyListeners();
    _patientDirectiveService.notifyListeners();
  }

  @override
  void dispose() {
    personalDetailsFormViewModel.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
    personalDetailsFormViewModel.removeListener(_reactToPersonalDetailsChange);
    super.dispose();
  }

  void onDownloadDirectivePressed(BuildContext context) {
    logger.w('downloading directive not implemented yet');
  }
}
