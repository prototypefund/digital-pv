import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';

class Routes {
  Routes._();

  static const patientDirective = 'patient-directive/';

  static const welcome = '/';
  static const positiveAspects = '/${patientDirective}current-situation/positive-aspects';
  static const addPositiveAspect = '/${patientDirective}current-situation/positive-aspects/add';
  static const negativeAspects = '/${patientDirective}current-situation/negative-aspects';
  static const evaluateCurrentAspects = '/${patientDirective}current-situation/evaluate';
  static const generalTreatmentObjective = '/${patientDirective}treatment-objective';
  static const treatmentActivities = '/${patientDirective}treatment-objective/treatment-activities';
  static const futureSituations = '/${patientDirective}future-situations';
  static const trustedThirdParty = '/${patientDirective}trusted-third-party';
  static const generalInformationAboutPatientDirective = '/${patientDirective}general-information';
  static const personalDetails = '/${patientDirective}personal-details';
  static const pdf = '/${patientDirective}directive-pdf';

  static const focusParam = 'focus';

  static String buildShowFutureSituationsRoute({required FutureSituation highlightedSituation}) {
    return '$futureSituations?$focusParam=${highlightedSituation.name}';
  }

  static String buildShowPositiveAspectRoute({required Aspect highlightedSituation}) {
    return '$positiveAspects?$focusParam=${highlightedSituation.name}';
  }

  static String buildShowNegativeAspectRoute({required Aspect highlightedSituation}) {
    return '$negativeAspects?$focusParam=${highlightedSituation.name}';
  }
}
