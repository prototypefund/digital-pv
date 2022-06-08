import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/logging.dart';

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
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

  bool get showPosistiveAspectsSignificanceLabel => l10n.significanceSliderLabel.isNotEmpty;

  String get positiveAspectsSignificanceHighLabel => l10n.significanceHigh;

  String get positiveAspectsSignificanceLowLabel => l10n.significanceLow;

  String get addPositiveAspectCallToActionText => l10n.addPositiveAspectCallToAction;

  bool get showNoPositiveAspectsMessage => positiveAspects.isEmpty;

  String get noPositiveAspectsMessageText => l10n.positiveAspectsEmptyText;

  final List<Aspect> _positiveAspects = [
    Aspect(name: "Zeit mit der Familie verbringen", weight: Weight(value: 0.7)),
    Aspect(name: "Haustier", weight: Weight(value: 0.5)),
    Aspect(name: "Reisen", weight: Weight(value: 0.4)),
    Aspect(name: "Essen", weight: Weight(value: 0.2)),
    Aspect(name: "Skifahren", weight: Weight(value: 0.25))
  ];

  void changeAspectWeight({required Aspect aspect, required double weight}) {
    logger.v('changing weight of $aspect to $weight');
    aspect.weight = Weight(value: weight);
    notifyListeners();
  }

  List<Aspect> get positiveAspects => _positiveAspects;
}
