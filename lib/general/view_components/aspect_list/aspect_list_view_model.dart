import 'package:flutter/material.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/logging.dart';

/// this model can be used as part of another view model, which displays a lists of aspects
/// The implementing model needs to define some concrete implementations. The model can then be provided to an AspectList
/// and will correctly visualize and work with services
/// Manipulation of the patient directive is done directly by this model
abstract class AspectListViewModel<AspectType extends Aspect>
    with Logging, RootContextL10N, ChangeNotifier, AspectViewModel {
  AspectListViewModel(
      {required this.scrollController, this.onAspectAdded, this.onAspectRemoved, required this.focusAspect})
      : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    _updateAspectsFromService(sortAspects: true);
  }

  bool _hasScrolledToFocusItem = false;

  final ScrollController scrollController;

  /// can be used to manipulate the view to react to new aspects, for instance with animated lists
  ValueChanged<AspectType>? onAspectAdded;

  /// can be used to manipulate the view to react to removed aspects, for instance with animated lists
  ValueChanged<AspectType>? onAspectRemoved;

  List<AspectType> _aspects = <AspectType>[];

  AspectListChoice<AspectType> get aspectListChoice;

  final PatientDirectiveService _patientDirectiveService;

  final AspectType? focusAspect;

  bool get showTreatmentOptions;

  bool get showEmptyAspectListsMessage => _aspects.isEmpty;

  String get emptyAspectListsMessageText;

  bool get isAddAspectCallToActionEnabled => true;

  String getRemoveAspectConfirmationQuestionLocalization(String aspectName);

  String get removeAspectConfirmationCancel;

  String get removeAspectConfirmationRemove;

  String get simulateLabel;

  bool get isSimulateAspectEnabled;

  VoidCallback? addAspectCallToActionPressed(BuildContext context) =>
      isAddAspectCallToActionEnabled ? () => onAddAspectCallToActionPressed(context) : null;

  void onAddAspectCallToActionPressed(BuildContext context);

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
  }

  void _updateAspectsFromService({required bool sortAspects}) {
    final currentPatientDirective = _patientDirectiveService.currentPatientDirective;

    final oldAspects = _aspects;
    final allAspectsFromDirective = List.of(aspectListChoice(currentPatientDirective));

    final removedAspects = oldAspects.toSet().difference(allAspectsFromDirective.toSet());
    logger.v('handling ${removedAspects.length} removed aspects');
    for (final aspect in removedAspects) {
      onAspectRemoved?.call(aspect);
      _aspects.remove(aspect);
    }

    _aspects = allAspectsFromDirective;

    if (sortAspects) {
      _sortAspects();
    } else {
      /// we get updates by the service all the time when adapting weights, but only want
      /// to reorder the animated list once adjusting the weights is complete

      _sortAspectsAccordingToOldOrder(oldAspects);
    }

    final newAspects = _aspects.toSet().difference(oldAspects.toSet());
    logger.v('handling ${newAspects.length} new aspects');
    for (final aspect in newAspects) {
      onAspectAdded?.call(aspect);
    }

    final focusAspect = this.focusAspect;
    if (aspects.isNotEmpty && !_hasScrolledToFocusItem && focusAspect != null) {
      _hasScrolledToFocusItem = true;

      _performScrollToAspect(focusAspect);
    }
  }

  Future<void> _performScrollToAspect(AspectType focusAspect) async {
    logger.d('will scroll to $focusAspect, but first waiting 300 ms');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final indexOfFocusItem = aspects.indexOf(focusAspect);
    final offset = Sizes.aspectListItemHeight * indexOfFocusItem;
    logger.d('start scrolling to $focusAspect at offset $offset');
    scrollController.jumpTo(offset);
    logger.d('scrolling to $focusAspect DONE');
  }

  void toggleSimulation({required AspectType aspect}) {
    logger.w('toggling simulation not implemented in base class - noop');
  }

  void _reactToPatientDirectiveChange() {
    logger.v('aspect list reacting to patient directive change');
    final List<AspectType> aspectsInService = aspectListChoice(_patientDirectiveService.currentPatientDirective);
    final bool sortAspects;
    if (aspectsInService.length != _aspects.length) {
      logger.i("an aspect was removed or added, refreshing view's list of elements and sorting them anew");
      sortAspects = true;
    } else {
      sortAspects = false;
    }
    _updateAspectsFromService(sortAspects: sortAspects);
    notifyListeners();
  }

  void changeAspectWeight({required AspectType aspect, required double weight}) {
    logger.v('changing weight of $aspect to $weight');

    final currentDirective = _patientDirectiveService.currentPatientDirective;

    _aspects.firstWhere((element) => element == aspect).weight = Weight(value: weight);

    _patientDirectiveService.currentPatientDirective = currentDirective;
  }

  void changeAspectTreatmentOption({required FutureSituation futureSituation}) {}

  AspectPositionChange onAspectWeightAdjustmentDone({required AspectType aspect}) {
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
            title: Text(getRemoveAspectConfirmationQuestionLocalization(aspect.name)),
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

  List<AspectType> get aspects => _aspects;

  void _sortAspects() {
    _aspects.sort((aspect1, aspect2) => aspect2.weight.value.compareTo(aspect1.weight.value));
  }

  void _sortAspectsAccordingToOldOrder(List<AspectType> oldOrder) {
    _aspects.sort((aspect1, aspect2) => oldOrder.indexOf(aspect1).compareTo(oldOrder.indexOf(aspect2)));
  }
}

class AspectPositionChange {
  AspectPositionChange({required this.oldIndex, required this.newIndex});

  final int oldIndex;
  final int newIndex;
}
