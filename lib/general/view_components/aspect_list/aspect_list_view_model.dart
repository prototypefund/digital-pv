import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/directive_visualization/triangle_painter.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_list_view_model.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_list_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_list_view_model.dart';

/// this model can be used as part of another view model, which displays a lists of aspects
/// The implementing model needs to define some concrete implementations. The model can then be provided to an AspectList
/// and will correctly visualize and work with services
/// Manipulation of the patient directive is done directly by this model
abstract class AspectListViewModel<AspectType extends Aspect>
    with Logging, RootContextL10N, ChangeNotifier, AspectViewModel {
  AspectListViewModel(
      {required this.scrollController, this.onAspectAdded, this.onAspectRemoved, required this.focusAspect})
      : _patientDirectiveService = getIt.get() {
    // Future.delayed(const Duration(seconds: 1)).then((value) {
    //   _aspects = [
    //     if (runtimeType == FutureSituationsListViewModel)
    //       FutureSituation(
    //           name: "Was wäre wenn-Situation und zugehörige Maßnahmen",
    //           weight: Weight(value: 0.5),
    //           treatmentActivitiyPreferences: []) as AspectType,
    //     if (runtimeType != FutureSituationsListViewModel)
    //       Aspect(name: "Ihr Aspekt", weight: Weight(value: 0.4)) as AspectType,
    //   ];
    // });
    notifyListeners();
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    _updateAspectsFromService(sortAspects: true);
  }

  final ContentService _contentService = getIt.get();

  String get selectItemTitle => "## Welchen Aspekt möchten Sie beschreiben?";
  final TrianglePainter trianglePainter = TrianglePainter();
  final TrianglePainter trianglePainterRight = TrianglePainter(tipDirection: TipDirection.right);
  late PageController pageController;

  String get cardTitle;
  String cardSubtitle(int index);

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

  double get listItemHeight {
    if (showTreatmentOptions) {
      return Sizes.aspectListItemWithTreatmentOptionsHeight;
    } else {
      return Sizes.aspectListItemWithoutTreatmentOptionsHeight;
    }
  }

  VoidCallback? addAspectCallToActionPressed(BuildContext context) =>
      isAddAspectCallToActionEnabled ? () => onAddAspectCallToActionPressed(context) : null;

  void onAddAspectCallToActionPressed(BuildContext context);

  String get aspectDataForJavascript {
    final List<Map<String, dynamic>> javascriptJsonArray = [];

    for (final positiveAspect in _patientDirectiveService.currentPatientDirective.positiveAspects) {
      javascriptJsonArray.add({
        "value": (positiveAspect.weight.value * 100).round(),
        "key": positiveAspect.name,
        "selected": false,
        "show_label": true,
        "positive": true
      });
    }
    for (final negativeAspect in _patientDirectiveService.currentPatientDirective.negativeAspects) {
      javascriptJsonArray.add({
        "value": (negativeAspect.weight.value * 100).round(),
        "key": negativeAspect.name,
        "selected": false,
        "show_label": true,
        "positive": false
      });
    }
    final jsonArray = jsonEncode(javascriptJsonArray);

//     const jsonArray = """
// [
//     { value: 40, key: "Unabhängigkeit", selected: false  , show_label: false , positive: true},
//     { value: 55, key: "Gesundheit", selected: false   , show_label: false, positive: true},
//     { value: 33, key: "Finanzen", selected: false  , show_label: false, positive: true},
//     { value: 20, key: "Freunde", selected: false   , show_label: false, positive: true},
//     { value: 14, key: "Natur", selected: false  , show_label: false, positive: true},
//     { value: 12, key: "Mein Hund",  selected: false   , show_label: false, positive: true},
//     { value: 10, key: "Arbeit", selected: false , show_label: false, positive: true},
//     { value: 83, key: "Genesung", selected: true , show_label: true, positive: true},
//     { value: 83, key: "Genesung", selected: false , show_label: false, positive: false},
//     { value: 13, key: "Genesung", selected: false , show_label: false, positive: false},
//     { value: 23, key: "Genesung", selected: true , show_label: true, positive: false},
//     { value: 55, key: "Gesundheit", selected: false   , show_label: false, positive: false},
// ]""";
    final jsonData = """
    // Read data
    var data = $jsonArray; 
""";

    return jsonData;
  }

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
    logger.t('handling ${removedAspects.length} removed aspects');
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
    logger.t('handling ${newAspects.length} new aspects');
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
    final offset = listItemHeight * indexOfFocusItem;
    logger.d('start scrolling to $focusAspect at offset $offset');
    scrollController.jumpTo(offset);
    logger.d('scrolling to $focusAspect DONE');
  }

  void toggleSimulation({required AspectType aspect}) {
    logger.w('toggling simulation not implemented in base class - noop');
  }

  void _reactToPatientDirectiveChange() {
    logger.t('aspect list reacting to patient directive change');
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
    logger.t('changing weight of $aspect to $weight');

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
  List<AspectType> _allAspects = [];

  List<AspectType> get allAspects {
    List<AspectsExample> examples = [];
    switch (runtimeType) {
      case FutureSituationsListViewModel:
        examples = _contentService.futureSituationsExamples;
        break;
      case PositiveAspectsListViewModel:
        examples = _contentService.positiveAspectsExamples;
        break;
      case NegativeAspectsListViewModel:
        examples = _contentService.negativeAspectsExamples;
        break;
    }
    if (_allAspects.isEmpty) {
      _allAspects = [
        // ..._aspects,
        if (runtimeType != FutureSituationsListViewModel)
          Aspect(name: "Ihr Aspekt", description: "Eigener Aspekt", weight: Weight(value: 0.5)) as AspectType,
        if (runtimeType == FutureSituationsListViewModel)
          FutureSituation(name: "Ihre Situation", weight: Weight(value: 0.5), treatmentActivitiyPreferences: [])
              as AspectType,
        ...examples.map((e) => runtimeType == FutureSituationsListViewModel
            ? FutureSituation(name: e.example.title, weight: Weight(value: 0.5), treatmentActivitiyPreferences: [])
                as AspectType
            : Aspect(name: e.example.group, description: e.example.title, weight: Weight(value: 0.5)) as AspectType)
      ];
    }
    return _allAspects;
  }

  AspectType? get selectedAspect => _allAspects.firstWhereOrNull((element) => element.isSelected);

  void onAspectSelected(AspectType aspect, {bool selected = true}) {
    _allAspects = _allAspects.map((e) => e..isSelected = false).toList();
    final index = _allAspects.indexOf(aspect);
    _allAspects[index] = _allAspects[index]..isSelected = selected;

    notifyListeners();
  }

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
