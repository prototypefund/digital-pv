import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations.dart';

class FutureSituationsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  FutureSituationsViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToFutureSituationChange);
    _updateFutureSituationAspectsFromService();
  }

  final PatientDirectiveService _patientDirectiveService;

  late GlobalKey<AnimatedListState> listKey;

  AnimatedListState? get _animatedList => listKey.currentState;

  double _weight = 0.5;

  double get weight => _weight;

  set weight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  String get futureSituationsTitle => l10n.futureSituationsTitle;

  String get futureSituationsTitleExplanation => l10n.futureSituationsTitleExplanation;

  String get addFutureSituationAspectTextfieldHint => l10n.addFutureSituationAspectTextfieldHint;

  String get addFutureSituationAspectText => l10n.addFutureSituationAspect;

  String get examplesTitle => l10n.examples;

  bool get addFutureSituationAspectActionEnabled => aspectTextFieldController.text.trim().isNotEmpty;

  void addFutureSituationAspect(BuildContext context) =>
      addFutureSituationAspectActionEnabled ? onAddFutureSituationAspectActionPressed(context) : null;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
  }

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  void onAddFutureSituationAspectActionPressed(BuildContext context) {
    final Aspect newPositiveAspect = Aspect(name: aspectTextFieldController.text.trim(), weight: Weight(value: weight));
    final PatientDirective currentDirective = _patientDirectiveService.currentPatientDirective;
    currentDirective.futureSituationAspects.add(newPositiveAspect);
    _patientDirectiveService.currentPatientDirective = currentDirective;
    _animatedList?.insertItem(currentDirective.futureSituationAspects.length - 1);
  }

  void changeAspectWeight({required Aspect aspect, required double weight}) {
    logger.v('changing weight of $aspect to $weight');

    final currentDirective = _patientDirectiveService.currentPatientDirective;

    _futureSituationAspects.firstWhere((element) => element == aspect).weight = Weight(value: weight);

    _patientDirectiveService.currentPatientDirective = currentDirective;
  }

  AspectPositionChange onAspectWeightAdjustmentDone({required Aspect aspect}) {
    final int oldIndex = _futureSituationAspects.indexOf(aspect);
    _sortAspects();
    final int newIndex = _futureSituationAspects.indexOf(aspect);

    return AspectPositionChange(oldIndex: oldIndex, newIndex: newIndex);
  }

  void removeItem(int index, AnimatedListRemovedItemBuilder builder) {
    _animatedList?.removeItem(index, builder);
  }

  Future<bool> removeAspect(
      {required Aspect aspect,
      required BuildContext context,
      int? index,
      AnimatedListRemovedItemBuilder? builder}) async {
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

      currentDirective.futureSituationAspects.remove(aspect);
      _patientDirectiveService.currentPatientDirective = currentDirective;
      return true;
    } else {
      return false;
    }
  }

  List<Aspect> get futureSituationAspects => _futureSituationAspects;

  List<Aspect> _futureSituationAspects = [];

  final TextEditingController aspectTextFieldController = TextEditingController();

  bool get showNoFutureSituationAspectsMessage => _futureSituationAspects.isEmpty;

  String get noFutureSituationAspectsMessageText => l10n.positiveAspectsEmptyText;

  void _sortAspects() {
    _futureSituationAspects.sort((aspect1, aspect2) => aspect2.weight.value.compareTo(aspect1.weight.value));
  }

  void _updateFutureSituationAspectsFromService() {
    _futureSituationAspects = List.of(_patientDirectiveService.currentPatientDirective.futureSituationAspects);
    _sortAspects();
  }

  void _reactToFutureSituationChange() {
    if (_patientDirectiveService.currentPatientDirective.futureSituationAspects.length !=
        _futureSituationAspects.length) {
      logger.i("an aspect was removed or added, refreshing view's list of elements and sorting them anew");
      _updateFutureSituationAspectsFromService();
    }
    notifyListeners();
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.treatmentActivities);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.trustedThirdParty);
  }

  List<Group> get examples {
    return [
      Group(title: l10n.futureSituationsGroupTitleSevereImpairement, children: [
        Item(
            title: l10n.futureSituationsExampleIntensiveCare,
            description: l10n.futureSituationsExampleIntensiveCareDescription),
        Item(
            title: l10n.futureSituationsExampleSevereImpairement,
            description: l10n.futureSituationsExampleSevereImpairementDescription),
        Item(
            title: l10n.futureSituationsExampleIntellectualImpairment,
            description: l10n.futureSituationsExampleIntellectualImpairmentDescription)
      ]),
      Group(title: l10n.futureSituationsGroupTitleUncertainCondition, children: [
        Item(
            title: l10n.futureSituationsExampleWakingComa,
            description: l10n.futureSituationsExampleWakingComaDescription)
      ]),
      Group(title: l10n.futureSituationsGroupDeathInescapable, children: [
        Item(title: l10n.futureSituationsExampleDeadlyDisease),
        Item(title: l10n.futureSituationsExampleProcessOfDying),
      ]),
    ];
  }

  void chooseExample(String text) {
    aspectTextFieldController.text = text;
    notifyListeners();
  }
}
