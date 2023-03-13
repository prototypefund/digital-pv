import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/future_situations_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_list_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';

class FutureSituationsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  FutureSituationsViewModel() : _futureSituationsListViewModel = FutureSituationsListViewModel() {
    _contentService.addListener(notifyListeners);
  }

  final AspectListViewModel _futureSituationsListViewModel;

  final ContentService _contentService = getIt.get();

  final NewFutureSituationViewModel newFutureSituationViewModel = NewFutureSituationViewModel();

  FutureSituationsPage get pageContent => _contentService.futureSituationsPage;

  AspectListViewModel get futureSituationsListViewModel => _futureSituationsListViewModel;

  @override
  void dispose() {
    super.dispose();
    _futureSituationsListViewModel.dispose();
    _contentService.removeListener(notifyListeners);
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.treatmentActivities);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.trustedThirdParty);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showFloatingAspectVisualizationIfSpaceAvailable => true;

  @override
  bool get showTreatmentGoalInVisualization => true;
}
