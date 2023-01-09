import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_list_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';

class FutureSituationsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  FutureSituationsViewModel() : _futureSituationsListViewModel = FutureSituationsListViewModel() {
    _futureSituationsListViewModel.addListener(_reactToAspectListChange);
  }

  final AspectListViewModel _futureSituationsListViewModel;

  final NewFutureSituationViewModel newFutureSituationViewModel = NewFutureSituationViewModel();

  String get futureSituationsTitle => l10n.futureSituationsTitle;

  String get futureSituationsTitleExplanation => l10n.futureSituationsTitleExplanation;

  AspectListViewModel get futureSituationsListViewModel => _futureSituationsListViewModel;

  @override
  void dispose() {
    super.dispose();
    _futureSituationsListViewModel.removeListener(_reactToAspectListChange);
    _futureSituationsListViewModel.dispose();
  }

  void _reactToAspectListChange() {}

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.treatmentActivities);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.trustedThirdParty);
  }
}
