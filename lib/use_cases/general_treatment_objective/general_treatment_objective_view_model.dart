import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

class GeneralTreatmentObjectiveViewModel
    with ChangeNotifier, RootContextL10N
    implements CreationProcessNavigationViewModel {
  @override
  bool get backButtonEnabled => true;

  @override
  String get backButtonText => l10n.navigationBack;

  @override
  bool get nextButtonEnabled => true;

  @override
  String get nextButtonText => l10n.navigationNext;

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.evaluateCurrentAspects);
  }

  @override
  void onNextButtonPressed(BuildContext context) {}
}
