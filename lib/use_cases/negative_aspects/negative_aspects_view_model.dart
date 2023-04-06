import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/negative_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_list_view_model.dart';
import 'package:pd_app/use_cases/negative_aspects/new_negative_aspect_view_model.dart';

class NegativeAspectsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  NegativeAspectsViewModel({required Aspect? focusAspect})
      : newNegativeAspectViewModel = NewNegativeAspectViewModel(autofocus: focusAspect == null) {
    _negativeAspectsListViewModel =
        NegativeAspectsListViewModel(focusAspect: focusAspect, scrollController: scrollController);
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService = getIt.get();

  late AspectListViewModel _negativeAspectsListViewModel;

  final NewNegativeAspectViewModel newNegativeAspectViewModel;

  NegativeAspectsPage get pageContent => _contentService.negativeAspectsPage;

  AspectListViewModel get negativeAspectsListViewModel => _negativeAspectsListViewModel;

  @override
  void dispose() {
    super.dispose();
    _negativeAspectsListViewModel.dispose();
    _contentService.removeListener(notifyListeners);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showFloatingAspectVisualizationIfSpaceAvailable => true;

  @override
  bool get showTreatmentGoalInVisualization => false;

  @override
  String get aspectSignificanceHighLabel => _contentService.negativeAspectsPage.aspectListWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.negativeAspectsPage.aspectListWidget.lowSignificanceLabel;
}
