import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/navigation/routes.dart';
import 'package:pd_app/utils/l10n_mixin.dart';

class NegativeAspectsViewModel with ChangeNotifier, RootContextL10N implements CreationProcessNavigationViewModel {
  @override
  bool get backButtonEnabled => true;

  @override
  String get backButtonText => l10n.navigationBack;

  @override
  bool get nextButtonEnabled => false;

  @override
  String get nextButtonText => l10n.navigationNext;

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.positiveAspects);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.evaluateCurrentAspects);
  }
}
