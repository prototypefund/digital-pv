import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/use_cases/add_positive_aspect/new_positive_aspect_view_model.dart';

class AddPositiveAspectViewModel extends CreationProcessNavigationViewModel with AspectViewModel {
  AddPositiveAspectViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    newPositiveAspectViewModel.addListener(_reactToAspectViewModelChange);
  }

  final PatientDirectiveService _patientDirectiveService;

  final NewPositiveAspectViewModel newPositiveAspectViewModel = NewPositiveAspectViewModel();

  String get examplesText => l10n.examples;

  String get addPositiveAspectTitle => l10n.addPositiveAspectTitle;

  String get addPositiveAspectExplanation => l10n.addPositiveAspectExplanation;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
    newPositiveAspectViewModel.removeListener(_reactToAspectViewModelChange);
  }

  final TextEditingController aspectTextFieldController = TextEditingController();

  @override
  bool get nextButtonEnabled => newPositiveAspectViewModel.addAspectActionEnabled;

  @override
  String get nextButtonText => l10n.addPositiveAspectNavigationButton;

  String get addPositiveAspectTextfieldHint => l10n.addPositiveAspectTextFieldHint;

  String get addPositiveAspectActionText => l10n.addPositiveAspectCallToAction;

  double _weight = 0.5;

  @override
  void onNextButtonPressed(BuildContext context) {
    newPositiveAspectViewModel.onAddAspectActionPressed(context);
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
    } else {
      context.go(Routes.positiveAspects);
    }
  }

  void _reactToAspectViewModelChange() {
    notifyListeners();
  }

  bool get addPositiveAspectActionEnabled => aspectTextFieldController.text.trim().isNotEmpty;

  double get weight => _weight;

  set weight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  List<String> get examples {
    return [
      l10n.spendTimeWithFamily,
      l10n.pet,
      l10n.myHome,
      l10n.personalContacts,
      l10n.myWork,
      l10n.travelling,
      l10n.jogging,
      l10n.ridingTheBike,
      l10n.cooking,
      l10n.writingBooks,
    ];
  }

  void chooseExample(String text) {
    aspectTextFieldController.text = text;
    notifyListeners();
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;
}
