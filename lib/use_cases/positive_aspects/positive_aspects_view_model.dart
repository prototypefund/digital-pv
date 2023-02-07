import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/positive_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_list_view_model.dart';

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  PositiveAspectsViewModel()
      : _positiveAspectListViewModel = PositiveAspectsListViewModel(),
        _contentService = getIt.get() {
    _positiveAspectListViewModel.addListener(_reactToAspectListChange);
  }

  final ContentService _contentService;
  final AspectListViewModel _positiveAspectListViewModel;

  PositiveAspectsPage get pageContent => _contentService.positiveAspectsPage;

  AspectListViewModel get positiveAspectListViewModel => _positiveAspectListViewModel;

  @override
  void dispose() {
    super.dispose();
    _positiveAspectListViewModel.removeListener(_reactToAspectListChange);
    _positiveAspectListViewModel.dispose();
  }

  void _reactToAspectListChange() {
    notifyListeners();
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.welcome);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.negativeAspects);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showFloatingAspectVisualizationIfSpaceAvailable => true;

  @override
  bool get showTreatmentGoalInVisualization => false;
}
