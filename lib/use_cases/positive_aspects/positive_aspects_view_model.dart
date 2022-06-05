import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel {
  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.welcome);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.negativeAspects);
  }

  bool get addPositiveAspectCallToActionEnabled => true;

  VoidCallback? get addPositiveAspectCallToActionPressed =>
      addPositiveAspectCallToActionEnabled ? () => onAddPositiveAspectCallToActionPressed : null;

  void onAddPositiveAspectCallToActionPressed() {}

  String get positiveAspectsHeadlineText => l10n.positiveAspectsHeadline;

  String get positiveAspectsExplanationText => l10n.positiveAspectsExplanation;

  String get positiveAspectsSignificanceLabel => l10n.significance;

  String get positiveAspectsSignificanceHighLabel => l10n.significanceHigh;

  String get positiveAspectsSignificanceLowLabel => l10n.significanceLow;

  String get addPositiveAspectCallToActionText => l10n.addPositiveAspectCallToAction;

  bool get showNoPositiveAspectsMessage => true;

  String get noPositiveAspectsMessageText => l10n.positiveAspectsEmptyText;
}
