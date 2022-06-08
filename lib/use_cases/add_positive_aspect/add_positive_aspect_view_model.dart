import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';

class AddPositiveAspectViewModel extends CreationProcessNavigationViewModel {
  @override
  bool get nextButtonEnabled => false;

  @override
  String get nextButtonText => l10n.addPositiveAspectNavigationButton;

  String get addPositiveAspectTextfieldHint => l10n.addPositiveAspectTextFieldHint;

  @override
  void onNextButtonPressed(BuildContext context) {}

  @override
  void onBackButtonPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
    } else {
      context.go(Routes.positiveAspects);
    }
  }
}
