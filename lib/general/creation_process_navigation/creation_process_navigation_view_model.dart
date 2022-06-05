import 'package:flutter/material.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

abstract class CreationProcessNavigationViewModel with RootContextL10N, ChangeNotifier {
  String get nextButtonText => l10n.navigationNext;

  String get backButtonText => l10n.navigationBack;

  void onBackButtonPressed(BuildContext context);

  void onNextButtonPressed(BuildContext context);

  bool get backButtonEnabled => true;

  bool get nextButtonEnabled => true;
}
