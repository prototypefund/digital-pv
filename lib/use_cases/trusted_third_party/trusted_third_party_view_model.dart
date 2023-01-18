import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/person_of_trust.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_form_view_model.dart';

class TrustedThirdPartyViewModel extends CreationProcessNavigationViewModel with Logging {
  TrustedThirdPartyViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
    _createThirdPartyFormViewModelsFromPatientDirective();
  }

  final PatientDirectiveService _patientDirectiveService;

  List<TrustedThirdPartyFormViewModel> _trustedThirdPartyFormViewModels = [];

  String get headline => l10n.personOfTrustTitle;

  String get summary => l10n.personOfTrustExplanation;

  String get designatePersonLabel => l10n.personOfTrustDesignatePerson(trustedPersonViewModels.length);

  List<TrustedThirdPartyFormViewModel> get trustedPersonViewModels => _trustedThirdPartyFormViewModels;

  String get addPersonOfTrustActionLabel => l10n.personOfTrustAddPerson;

  IconData get addPersonOfTrustActionIcon => Icons.add_circle;

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.futureSituations);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.generalInformationAboutPatientDirective);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => true;

  void addPersonOfTrust(BuildContext context) {
    logger.i('adding additional person of trust to directive');

    final PatientDirective currentDirective = _patientDirectiveService.currentPatientDirective;

    final currentThirdParties = List.of(currentDirective.personsOfTrust);
    currentThirdParties.add(PersonOfTrust());
    currentDirective.personsOfTrust = currentThirdParties;
    _patientDirectiveService.currentPatientDirective = currentDirective;
  }

  void _createThirdPartyFormViewModelsFromPatientDirective() {
    for (final TrustedThirdPartyFormViewModel oldViewModel in _trustedThirdPartyFormViewModels) {
      oldViewModel.dispose();
    }

    final List<TrustedThirdPartyFormViewModel> formViewModels = [];
    _patientDirectiveService.currentPatientDirective.personsOfTrust.asMap().forEach((index, value) {
      final TrustedThirdPartyFormViewModel newViewModel = TrustedThirdPartyFormViewModel(
          readPersonFromService: () => _patientDirectiveService.currentPatientDirective.personsOfTrust[index]);
      formViewModels.add(newViewModel);
    });
    _trustedThirdPartyFormViewModels = formViewModels;
  }

  void _reactToPatientDirectiveChanges() {
    _createThirdPartyFormViewModelsFromPatientDirective();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
  }

  @override
  bool get nextButtonEnabled {
    return true;
  }
}
