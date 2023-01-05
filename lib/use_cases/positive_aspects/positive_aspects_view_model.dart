import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  PositiveAspectsViewModel()
      : _positiveAspectListViewModel = AspectListViewModel(
            showTreatmentOptions: false,
            aspectListChoice: (PatientDirective patientDirective) => patientDirective.positiveAspects) {
    _positiveAspectListViewModel.addListener(_reactToAspectListChange);
  }

  final AspectListViewModel _positiveAspectListViewModel;

  String get positiveAspectsHeadlineText => l10n.positiveAspectsHeadline;

  String get positiveAspectsExplanationText => l10n.positiveAspectsExplanation;

  AspectListViewModel get positiveAspectListViewModel => _positiveAspectListViewModel;

  @override
  void dispose() {
    super.dispose();
    _positiveAspectListViewModel.removeListener(_reactToAspectListChange);
    _positiveAspectListViewModel.dispose();
  }

  void _reactToAspectListChange() {
    notifyListeners();
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.welcome);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.negativeAspects);
  }
}
