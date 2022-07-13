import 'package:flutter/material.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_content_view_model.dart';

class WelcomeViewPageController extends PageController with RootContextL10N {
  late List<WelcomeViewPageContentViewModel> _dataSource;

  int get numberOfPages {
    return _dataSource.length;
  }

  WelcomeViewPageController() {
    _dataSource = [
      WelcomeViewPageContentViewModel(
          title: l10n.welcomeViewPageOneTitle,
          image: "assets/images/placeholder.png",
          description: l10n.welcomeViewPageOneDescription),
      WelcomeViewPageContentViewModel(
          title: l10n.welcomeViewPageTwoTitle,
          image: "assets/images/placeholder.png",
          description: l10n.welcomeViewPageTwoDescription),
      WelcomeViewPageContentViewModel(
          title: l10n.welcomeViewPageThreeTitle,
          image: "assets/images/placeholder.png",
          description: l10n.welcomeViewPageThreeDescription),
      WelcomeViewPageContentViewModel(
          title: l10n.welcomeViewPageFourTitle,
          image: "assets/images/placeholder.png",
          description: l10n.welcomeViewPageFourDescription)
    ];
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
}
