import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/logging.dart';

///
/// chooses from the given patient directive a list of aspects to read and manipulate
typedef AspectListChoice = List<Aspect> Function(PatientDirective patientDirective);

/// this model can be used as part of another view model, which displays a lists of aspects
/// The parent model provides a callback, which given a patient directive returns the list of aspects to show and change.
/// Manipulation of the patient directive is done directly by this model
class AspectListViewModel with Logging, RootContextL10N, ChangeNotifier, AspectViewModel {
  AspectListViewModel({required this.aspectListChoice, required this.showTreatmentOptions})
      : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    _updateAspectsFromService();
  }

  final bool showTreatmentOptions;

  late List<Aspect> _aspects;

  final AspectListChoice aspectListChoice;

  final PatientDirectiveService _patientDirectiveService;

  String get addAspectCallToActionText => l10n.addPositiveAspectCallToAction;

  bool get showEmptyAspectListsMessage => _aspects.isEmpty;

  String get emptyAspectListsMessageText => l10n.positiveAspectsEmptyText;

  bool get isAddAspectCallToActionEnabled => true;

  String Function(String aspectName) get removeAspectConfirmationQuestionLocalizationFunction =>
      l10n.removePositiveAspectConfirmationQuestion;

  String get removeAspectConfirmationCancel => l10n.removePositiveAspectConfirmationCancel;

  String get removeAspectConfirmationRemove => l10n.removePositiveAspectConfirmationRemove;

  VoidCallback? addAspectCallToActionPressed(BuildContext context) =>
      isAddAspectCallToActionEnabled ? () => onAddAspectCallToActionPressed(context) : null;

  void onAddAspectCallToActionPressed(BuildContext context) {
    context.push(Routes.addPositiveAspect);
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
  }

  void _updateAspectsFromService() {
    _aspects = List.of(_patientDirectiveService.currentPatientDirective.positiveAspects);
    _sortAspects();
  }

  void _reactToPatientDirectiveChange() {
    final List<Aspect> aspectsInService = aspectListChoice(_patientDirectiveService.currentPatientDirective);
    if (aspectsInService.length != _aspects.length) {
      logger.i("an aspect was removed or added, refreshing view's list of elements and sorting them anew");
      _updateAspectsFromService();
    }
    notifyListeners();
  }

  void changeAspectWeight({required Aspect aspect, required double weight}) {
    logger.v('changing weight of $aspect to $weight');

    final currentDirective = _patientDirectiveService.currentPatientDirective;

    _aspects.firstWhere((element) => element == aspect).weight = Weight(value: weight);

    _patientDirectiveService.currentPatientDirective = currentDirective;
  }

  AspectPositionChange onAspectWeightAdjustmentDone({required Aspect aspect}) {
    final int oldIndex = _aspects.indexOf(aspect);
    _sortAspects();
    final int newIndex = _aspects.indexOf(aspect);

    return AspectPositionChange(oldIndex: oldIndex, newIndex: newIndex);
  }

  Future<bool> removeAspect({required Aspect aspect, required BuildContext context}) async {
    logger.d('call to removing aspect $aspect');

    final bool? shouldRemoveAspect = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(removeAspectConfirmationQuestionLocalizationFunction(aspect.name)),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false), child: Text(removeAspectConfirmationCancel)),
              ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text(removeAspectConfirmationRemove))
            ],
          );
        });

    if (shouldRemoveAspect != null && shouldRemoveAspect) {
      final currentDirective = _patientDirectiveService.currentPatientDirective;

      final List<Aspect> aspectsInService = aspectListChoice(currentDirective);
      aspectsInService.remove(aspect);
      _patientDirectiveService.currentPatientDirective = currentDirective;

      return true;
    } else {
      return false;
    }
  }

  List<Aspect> get aspects => _aspects;

  void _sortAspects() {
    _aspects.sort((aspect1, aspect2) => aspect2.weight.value.compareTo(aspect1.weight.value));
  }
}

class AspectPositionChange {
  AspectPositionChange({required this.oldIndex, required this.newIndex});

  final int oldIndex;
  final int newIndex;
}
