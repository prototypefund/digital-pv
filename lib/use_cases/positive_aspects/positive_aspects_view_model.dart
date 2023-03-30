import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/positive_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/new_positive_aspect_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_list_view_model.dart';

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  PositiveAspectsViewModel({required Aspect? focusAspect})
      : newPositiveAspectViewModel = NewPositiveAspectViewModel(autofocus: focusAspect == null),
        _contentService = getIt.get() {
    _positiveAspectListViewModel = _positiveAspectListViewModel =
        PositiveAspectsListViewModel(focusAspect: focusAspect, scrollController: scrollController);
    _positiveAspectListViewModel.addListener(_reactToAspectListChange);
  }

  final ContentService _contentService;
  late AspectListViewModel _positiveAspectListViewModel;

  PositiveAspectsPage get pageContent => _contentService.positiveAspectsPage;

  AspectListViewModel get positiveAspectListViewModel => _positiveAspectListViewModel;

  final NewPositiveAspectViewModel newPositiveAspectViewModel;

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
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showFloatingAspectVisualizationIfSpaceAvailable => true;

  @override
  bool get showTreatmentGoalInVisualization => false;
}
