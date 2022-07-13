import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  PositiveAspectsViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
  }

  final PatientDirectiveService _patientDirectiveService;

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.welcome);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.negativeAspects);
  }

  bool get addPositiveAspectCallToActionEnabled => true;

  VoidCallback? addPositiveAspectCallToActionPressed(BuildContext context) =>
      addPositiveAspectCallToActionEnabled ? () => onAddPositiveAspectCallToActionPressed(context) : null;

  void onAddPositiveAspectCallToActionPressed(BuildContext context) {
    context.push(Routes.addPositiveAspect);
  }

  String get positiveAspectsHeadlineText => l10n.positiveAspectsHeadline;

  String get positiveAspectsExplanationText => l10n.positiveAspectsExplanation;

  String get positiveAspectsSignificanceLabel => l10n.significanceSliderLabel;

  bool get showPositiveAspectsSignificanceLabel => l10n.significanceSliderLabel.isNotEmpty;

  String get positiveAspectsSignificanceHighLabel => l10n.significanceHigh;

  String get positiveAspectsSignificanceLowLabel => l10n.significanceLow;

  String get addPositiveAspectCallToActionText => l10n.addPositiveAspectCallToAction;

  bool get showNoPositiveAspectsMessage => positiveAspects.isEmpty;

  String get noPositiveAspectsMessageText => l10n.positiveAspectsEmptyText;

  void changeAspectWeight({required Aspect aspect, required double weight}) {
    logger.v('changing weight of $aspect to $weight');

    final currentDirective = _patientDirectiveService.currentPatientDirective;

    currentDirective.positiveAspects.firstWhere((element) => element == aspect).weight = Weight(value: weight);

    _patientDirectiveService.currentPatientDirective = currentDirective;
  }

  void onAspectWeightAdjustmentDone() {
    _patientDirectiveService.sortAspects();
  }

  Future<void> removeAspect({required Aspect aspect, required BuildContext context}) async {
    logger.d('call to removing aspect $aspect');

    final bool? shouldRemoveAspect = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.removePositiveAspectConfirmationQuestion(aspect.name)),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(l10n.removePositiveAspectConfirmationCancel)),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(l10n.removePositiveAspectConfirmationRemove))
            ],
          );
        });

    if (shouldRemoveAspect != null && shouldRemoveAspect) {
      final currentDirective = _patientDirectiveService.currentPatientDirective;

      currentDirective.positiveAspects.remove(aspect);
      _patientDirectiveService.currentPatientDirective = currentDirective;
    }
  }

  List<Aspect> get positiveAspects => _patientDirectiveService.currentPatientDirective.positiveAspects;

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }
}
