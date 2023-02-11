import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/treatment_goal.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/logging.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfViewModel with ChangeNotifier, Logging, RootContextL10N {
  PdfViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
  }

  final PatientDirectiveService _patientDirectiveService;

  String get footerPlaceAndDate => l10n.pdfFooterPlaceAndDate;

  String get footerSignature => l10n.pdfFooterSignature;

  String get headerTitle => l10n.pdfHeaderTitle;

  String get personsOfTrust {
    final personsOfTrust = _patientDirectiveService.currentPatientDirective.personsOfTrust;

    final personsOfTrustResult =
        personsOfTrust.map((e) => '${e.personalDetails.surname} ${e.personalDetails.name}').join(' (Punkt VI.),\n');
    return '${l10n.pdfPersonsOfTrust}: $personsOfTrustResult';
  }

  String get directiveOf {
    final surname = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.surname!;
    final name = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.name!;

    return l10n.pdfDirectiveOf(surname, name);
  }

  String get introductionParagraph {
    // Still missing _patientDirectiveService.currentPatientDirective.patient.personalDetails.
    // Following are just placeholders
    final surname = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.surname!;
    final name = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.name!;
    final dateOfBirth =
        _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.dateOfBirth!;
    final city = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.city!;
    final zipCode = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.zipCode!;
    final country = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.country!;

    return l10n.pdfIntroductionParagraph(surname, name, dateOfBirth, zipCode, city, country);
  }

  String get generalHospitalizationPreference {
    return l10n.pdfGeneralHospitalizationPreference(
        _patientDirectiveService.currentPatientDirective.generalHospitalizationPreference.name);
  }

  String get generalIntensiveTreatmentPreference {
    return l10n.pdfGeneralIntensiveTreatmentPreference(
        _patientDirectiveService.currentPatientDirective.generalIntensiveTreatmentPreference.name);
  }

  String get generalResuscitationPreference {
    return l10n.pdfGeneralResuscitationPreference(
        _patientDirectiveService.currentPatientDirective.generalResuscitationPreference.name);
  }

  String get treatmentGoal {
    final goal = _patientDirectiveService.currentPatientDirective.generalTreatmentGoal;

    const paragraph = 'I.';
    if (goal.tendency == TreatmentGoalTendency.curative) {
      return l10n.pdfParagraphTreatmentTargetTitleCurative(paragraph);
    } else if (goal.tendency == TreatmentGoalTendency.palliative) {
      return l10n.pdfParagraphTreatmentTargetTitlePalliative(paragraph);
    } else {
      return l10n.pdfParagraphTreatmentTargetTitleUndefined(paragraph);
    }
  }

  String get paragraphTreatmentTarget => l10n.pdfParagraphTreatmentTarget;

  String get paragraphPrincipleWishTitle => l10n.pdfParagraphPrincipleWishTitle('II. ');
  String get paragraphSpecificMeasuresTitle => l10n.pdfParagraphSpecificMeasuresTitle('III. ');
  String get paragraphSpecificMeasures => l10n.paragraphSpecificMeasures;

  String get paragraphValidityTitle => l10n.pdfParagraphValidityTitle('IV. ');
  String get paragraphValidity => l10n.pdfParagraphValidity;

  String get paragraphReleaseSecrecyTitle => l10n.pdfParagraphReleaseSecrecyTitle('V. ');
  String get paragraphReleaseSecrecy => l10n.pdfParagraphReleaseSecrecy;
  String get representativesTitle => l10n.pdfParagraphRepresentativesTitle('VI. ');
  String get representatives {
    // Still missing _patientDirectiveService.currentPatientDirective.patient.personalDetails.
    // Following are just placeholders
    final surname = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.surname!;
    final name = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.name!;
    final dateOfBirth =
        _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.dateOfBirth!;
    final city = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.city!;
    final zipCode = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.zipCode!;
    final country = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.country!;
    final phone = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.phone!;
    final email = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.email!;
    return l10n.pdfParagraphRepresentatives(surname, name, dateOfBirth, zipCode, city, country, phone, email);
  }

  String get qrCodeData => "https://digital-pv.gitlab.io/app/develop/web/";

  String get patientName {
    // Still missing _patientDirectiveService.currentPatientDirective.patient.personalDetails.
    // Following are just placeholders
    final name = _patientDirectiveService.currentPatientDirective.personsOfTrust.first.personalDetails.name!;

    return name;
  }

  Future<pw.ImageProvider> get profilePicture {
    return networkImage('https://www.nfet.net/nfet.jpg');
  }

  String get paragraphEnclosedExplanationTitle => l10n.pdfParagraphEnclosedExplanationTitle('VII. ');
  String get paragraphEnclosedExplanation => l10n.pdfParagraphEnclosedExplanation;
  String get pdfParagraphConclusionTitle => l10n.pdfParagraphConclusionTitle('VIII. ');
  String get pdfParagraphConclusion => l10n.pdfParagraphConclusion;
  String get pdfParagraphAdviceTitle => l10n.pdfParagraphAdviceTitle('IX. ');
  String get pdfParagraphAdvice => l10n.pdfParagraphAdvice;

  String pageNumberOfTotalPages({required int pageNumber, required int pagesCount}) {
    return l10n.pdfPageNumberOfTotalPages(pageNumber, pagesCount);
  }

  String get createdAt {
    final now = DateTime.now();
    final formatter = DateFormat('dd.MM.yyyy hh:mm');
    final formattedDate = formatter.format(now);
    return l10n.pdfCreatedAt(formattedDate);
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
  }

  void _reactToPatientDirectiveChange() {}
}
