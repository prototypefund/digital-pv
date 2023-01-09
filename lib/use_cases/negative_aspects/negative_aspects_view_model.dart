import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_list_view_model.dart';
import 'package:pd_app/use_cases/negative_aspects/new_negative_aspect_view_model.dart';

class NegativeAspectsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  NegativeAspectsViewModel() : _negativeAspectsListViewModel = NegativeAspectsListViewModel();

  final AspectListViewModel _negativeAspectsListViewModel;

  final NewNegativeAspectViewModel newNegativeAspectViewModel = NewNegativeAspectViewModel();

  String get negativeAspectsTitle => l10n.negativeAspectsHeadline;

  String get negativeAspectsTitleExplanation => l10n.negativeAspectsTitleExplanation;

  AspectListViewModel get negativeAspectsListViewModel => _negativeAspectsListViewModel;

  @override
  void dispose() {
    super.dispose();
    _negativeAspectsListViewModel.dispose();
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.positiveAspects);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.evaluateCurrentAspects);
  }
}
