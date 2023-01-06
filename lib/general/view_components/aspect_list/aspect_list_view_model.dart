import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/logging.dart';

/// this model can be used as part of another view model, which displays a lists of aspects
/// The implementing model needs to define some concrete implementations. The model can then be provided to an AspectList
/// and will correctly visualize and work with services
/// Manipulation of the patient directive is done directly by this model
abstract class AspectListViewModel with Logging, RootContextL10N, ChangeNotifier, AspectViewModel {
  AspectListViewModel({this.onAspectAdded}) : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    _updateAspectsFromService();
  }

  /// can be used to manipulate the view to react to new aspects, for instance with animated lists
  ValueChanged<Aspect>? onAspectAdded;

  List<Aspect> _aspects = [];

  AspectListChoice get aspectListChoice;

  final PatientDirectiveService _patientDirectiveService;

  String get addAspectCallToActionText;

  bool get showTreatmentOptions;

  bool get showEmptyAspectListsMessage => _aspects.isEmpty;

  String get emptyAspectListsMessageText;

  bool get isAddAspectCallToActionEnabled => true;

  bool get showAddAspectCallToAction;

  String Function(String aspectName) get removeAspectConfirmationQuestionLocalizationFunction =>
      l10n.removePositiveAspectConfirmationQuestion;

  // TODO generalize this
  String get removeAspectConfirmationCancel => l10n.removePositiveAspectConfirmationCancel;

  // TODO generalize this
  String get removeAspectConfirmationRemove => l10n.removePositiveAspectConfirmationRemove;

  VoidCallback? addAspectCallToActionPressed(BuildContext context) =>
      isAddAspectCallToActionEnabled ? () => onAddAspectCallToActionPressed(context) : null;

  void onAddAspectCallToActionPressed(BuildContext context) {
    // TODO generalize this
    context.push(Routes.addPositiveAspect);
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
  }

  void _updateAspectsFromService() {
    final currentPatientDirective = _patientDirectiveService.currentPatientDirective;

    final oldAspects = _aspects;
    _aspects = List.of(aspectListChoice(currentPatientDirective));

    _sortAspects();

    for (final Aspect aspect in _aspects) {
      if (!oldAspects.contains(aspect)) {
        onAspectAdded?.call(aspect);
      }
    }
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
