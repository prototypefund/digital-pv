import 'package:flutter/material.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_content_view_model.dart';

class WelcomeViewPageController extends PageController with RootContextL10N, Logging {
  WelcomeViewPageController() {
    _rebuildContent();
    _contentService.addListener(_reactToContentServiceChange);
  }

  late List<WelcomeViewPageContentViewModel> _dataSource;

  final ContentService _contentService = getIt.get();

  int get numberOfPages {
    return _dataSource.length;
  }

  WelcomeViewPageContentViewModel modelAtIndex(int index) {
    return _dataSource[index];
  }

  WelcomeViewPageContentViewModel currentPageModel() {
    return _dataSource[currentPage];
  }

  int currentPage = 0;

  bool get isLastPage {
    return currentPage + 1 == _dataSource.length;
  }

  int get _lastPageIndex {
    return _dataSource.length - 1;
  }

  void jumpToLastPage() {
    jumpToPage(_lastPageIndex);
  }

  void _rebuildContent() {
    _dataSource = _contentService.onboarding.pages
        .map((e) => WelcomeViewPageContentViewModel(markdown: e.content, image: e.logo.assetPath))
        .toList();
  }

  void _reactToContentServiceChange() {
    logger.d('reacting to content service change');
    _rebuildContent();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(_reactToContentServiceChange);
  }
}
