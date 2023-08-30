import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/navigation_step.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

abstract class CreationProcessNavigationViewModel with RootContextL10N, ChangeNotifier {
  CreationProcessNavigationViewModel() {
    _contentService.addListener(notifyListeners);
  }

  void update() {
    notifyListeners();
  }

  bool get showAppBar => true;

  final ContentService _contentService = getIt.get();

  String get nextButtonText => l10n.navigationNext;

  String get backButtonText => l10n.navigationBack;

  bool get nextButtonShowArrow => true;

  final ScrollController scrollController = ScrollController();

  void onBackButtonPressed(BuildContext context) {
    context.go(previousRoute(context).path);
  }

  void onNextButtonPressed(BuildContext context) {
    context.go(nextRoute(context).path);
  }

  void onStepContinue(BuildContext context, int index) {
    // as welcome page is not part of the bread crumb navigation, we need to increase the index by one
    final int indexToGoTo = (index + 3) + 1; // + 3 because of upsert pages
    const routes = Routes.values;
    if (indexToGoTo >= routes.length || indexToGoTo < 0) {
      throw Exception('index $indexToGoTo is out of bounds for routes');
    }
    context.go(routes[indexToGoTo].path);
  }

  int currentStep(BuildContext context) => currentRouteIndex(context) - 3; // because of upsert pages

  bool get backButtonEnabled => true;

  bool get nextButtonEnabled => true;

  bool get nextButtonVisible => true;

  bool get backButtonVisible => true;

  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization;

  bool get showFloatingAspectVisualizationIfSpaceAvailable => false;

  bool get simulateFutureAspects => false;

  bool get showTreatmentGoalInVisualization;

  List<NavigationStep> get navigationSteps {
    return [
      _contentService.positiveAspectsPage.breadcrumbTitle,
      _contentService.negativeAspectsPage.breadcrumbTitle,
      _contentService.qualityOfLifePage.breadcrumbTitle,
      _contentService.treatmentGoalPage.breadcrumbTitle,
      _contentService.treatmentActivitiesPage.breadcrumbTitle,
      _contentService.futureSituationsPage.breadcrumbTitle,
      _contentService.trustedThirdPartyPage.breadcrumbTitle,
      _contentService.generalInformationAboutDirectivePage.breadcrumbTitle,
      _contentService.personalDetailsPage.breadcrumbTitle,
    ].map((e) => NavigationStep(stepName: e)).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }
}
