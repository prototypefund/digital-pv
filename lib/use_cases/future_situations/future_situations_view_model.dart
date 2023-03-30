import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/future_situations_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_list_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';

class FutureSituationsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  FutureSituationsViewModel({this.focusAspect})
      : newFutureSituationViewModel = NewFutureSituationViewModel(autofocus: focusAspect == null) {
    _futureSituationsListViewModel =
        FutureSituationsListViewModel(focusAspect: focusAspect, scrollController: scrollController);
    _contentService.addListener(notifyListeners);
  }

  late AspectListViewModel _futureSituationsListViewModel;

  final FutureSituation? focusAspect;

  final ContentService _contentService = getIt.get();

  final NewFutureSituationViewModel newFutureSituationViewModel;

  FutureSituationsPage get pageContent => _contentService.futureSituationsPage;

  AspectListViewModel get futureSituationsListViewModel => _futureSituationsListViewModel;

  @override
  void dispose() {
    super.dispose();
    _futureSituationsListViewModel.dispose();
    _contentService.removeListener(notifyListeners);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showFloatingAspectVisualizationIfSpaceAvailable => true;

  @override
  bool get showTreatmentGoalInVisualization => true;

  @override
  String get aspectSignificanceHighLabel => _contentService.futureSituationsPage.addAspectWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.futureSituationsPage.addAspectWidget.lowSignificanceLabel;

  @override
  bool get simulateFutureAspects => true;
}
