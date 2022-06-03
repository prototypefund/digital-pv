import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';

class TrustedThirdPartyViewModel extends CreationProcessNavigationViewModel {
  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.futureSituations);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.generalInformationAboutPatientDirective);
  }
}
