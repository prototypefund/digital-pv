import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/personal_details_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/services/pdf_service.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/pdf/pdf_view_model.dart';
import 'package:pd_app/use_cases/personal_details/personal_data_for_directive_view_model.dart';

enum NavigationSubStep { name, birthday, address, contact }

class PersonalDetailsViewModel extends CreationProcessNavigationViewModel with Logging {
  PersonalDetailsViewModel() : _patientDirectiveService = getIt.get() {
    personalDetailsFormViewModel = PersonalDataForDirectiveViewModel(
        personalDetails: _patientDirectiveService.currentPatientDirective.personalDetails);
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
    personalDetailsFormViewModel.addListener(_reactToPersonalDetailsChange);
    _contentService.addListener(notifyListeners);
  }

  NavigationSubStep _navigationStep = NavigationSubStep.name;
  NavigationSubStep get navigationStep => _navigationStep;

  late PersonalDetailsFormViewModel personalDetailsFormViewModel;

  final PatientDirectiveService _patientDirectiveService;

  final ContentService _contentService = getIt.get();

  //TODO: set validator for every step //personalDetailsFormViewModel.isInputValid();
  @override
  bool get nextButtonEnabled => true;

  @override
  bool get nextButtonShowArrow => false;

  @override
  String get nextButtonText {
    switch (_navigationStep) {
      case NavigationSubStep.name:
      case NavigationSubStep.birthday:
      case NavigationSubStep.address:
        return "Weiter";
      case NavigationSubStep.contact:
        return pageContent.downloadAsPdfActionLabel;
    }
  }

  PersonalDetailsPage get pageContent => _contentService.personalDetailsPage;

  String get introductionMarkdownContent => pageContent.intro;

  VoidCallback? downloadDirectiveAction(BuildContext context) {
    if (personalDetailsFormViewModel.isInputValid()) {
      return () => onDownloadDirectivePressed(context);
    } else {
      return null;
    }
  }

  VoidCallback? showDirectiveAction(BuildContext context) {
    if (personalDetailsFormViewModel.isInputValid()) {
      return () => onShowDirectivePressed(context);
    } else {
      return null;
    }
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    switch (_navigationStep) {
      case NavigationSubStep.name:
        _navigationStep = NavigationSubStep.birthday;
        break;
      case NavigationSubStep.birthday:
        _navigationStep = NavigationSubStep.address;
        break;
      case NavigationSubStep.address:
        _navigationStep = NavigationSubStep.contact;
        break;
      case NavigationSubStep.contact:
        onDownloadDirectivePressed(context);
        break;
    }
    notifyListeners();
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    switch (_navigationStep) {
      case NavigationSubStep.name:
        super.onBackButtonPressed(context);
        break;
      case NavigationSubStep.birthday:
        _navigationStep = NavigationSubStep.name;
        break;
      case NavigationSubStep.address:
        _navigationStep = NavigationSubStep.birthday;
        break;
      case NavigationSubStep.contact:
        _navigationStep = NavigationSubStep.address;
        break;
    }
    notifyListeners();
  }

  @override
  bool get nextButtonVisible => true;

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showTreatmentGoalInVisualization => true;

  String get downloadDirectiveLabel => pageContent.downloadAsPdfActionLabel;

  String get showDirectiveLabel => pageContent.showDirectiveActionLabel;

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
    _contentService.removeListener(notifyListeners);
    super.dispose();
  }

  void onDownloadDirectivePressed(BuildContext context) {
    final model = PdfViewModel();
    final service = PdfService(model);
    unawaited(service.downloadPdf());
  }

  void onShowDirectivePressed(BuildContext context) {
    onNextButtonPressed(context);
  }
}
