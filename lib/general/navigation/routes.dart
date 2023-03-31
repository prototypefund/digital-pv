import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  welcome,
  positiveAspects,
  // addPositiveAspect,
  negativeAspects,
  evaluateCurrentAspects,
  generalTreatmentObjective,
  treatmentActivities,
  futureSituations,
  trustedThirdParty,
  generalInformationAboutPatientDirective,
  personalDetails,
  pdf,
}

const focusParam = 'focus';

int currentRouteIndex(BuildContext context) =>
    Routes.values.indexWhere((element) => GoRouter.of(context).location.contains(element.path));

Routes nextRoute(BuildContext context) {
  if (currentRouteIndex(context) == Routes.values.length - 1) {
    throw Exception('No next route');
  }
  return Routes.values[currentRouteIndex(context) + 1];
}

Routes previousRoute(BuildContext context) {
  if (currentRouteIndex(context) == 0) {
    throw Exception('No previous route');
  }
  return Routes.values[currentRouteIndex(context) - 1];
}

String buildShowFutureSituationsRoute({required String paramValue}) =>
    '${Routes.futureSituations.path}?$focusParam=$paramValue';

String buildShowPositiveAspectRoute({required String paramValue}) =>
    '${Routes.positiveAspects.path}?$focusParam=$paramValue';

String buildShowNegativeAspectRoute({required String paramValue}) =>
    '${Routes.negativeAspects.path}?$focusParam=$paramValue';

extension RouteExtension on Routes {
  static const patientDirective = 'patientDirective/';

  String get path {
    switch (this) {
      case Routes.welcome:
        return '/';
      case Routes.positiveAspects:
        return '/${patientDirective}current-situation/positive-aspects';
      // case Routes.addPositiveAspect:
      //   return '/${patientDirective}current-situation/positive-aspects/add';
      case Routes.negativeAspects:
        return '/${patientDirective}current-situation/negative-aspects';
      case Routes.evaluateCurrentAspects:
        return '/${patientDirective}current-situation/evaluate';
      case Routes.generalTreatmentObjective:
        return '/${patientDirective}treatment-objective';
      case Routes.treatmentActivities:
        return '/${patientDirective}treatment-objective/treatment-activities';
      case Routes.futureSituations:
        return '/${patientDirective}future-situations';
      case Routes.trustedThirdParty:
        return '/${patientDirective}trusted-third-party';
      case Routes.generalInformationAboutPatientDirective:
        return '/${patientDirective}general-information';
      case Routes.personalDetails:
        return '/${patientDirective}personal-details';
      case Routes.pdf:
        return '/${patientDirective}directive-pdf';
      default:
        throw Exception('Invalid route');
    }
  }
}
