class Routes {
  Routes._();

  static const patientDirective = 'patient-directive/';

  static const welcome = '/';
  static const positiveAspects = '/${patientDirective}current-situation/positive-aspects';
  static const negativeAspects = '/${patientDirective}current-situation/negative-aspects';
  static const evaluateCurrentAspects = '/${patientDirective}current-situation/evaluate';
  static const generalTreatmentObjective = '/${patientDirective}treatment-objective';
  static const treatmentActivities = '/${patientDirective}treatment-objective/treatment-activities';
  static const futureSituations = '/${patientDirective}future-situations';
  static const trustedThirdParty = '/${patientDirective}trusted-third-party';
  static const generalInformationAboutPatientDirective = '/${patientDirective}general-information';
  static const personalDetails = '/${patientDirective}personal-details';
}
