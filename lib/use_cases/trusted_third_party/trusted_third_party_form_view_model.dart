import 'package:flutter/material.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/person_of_trust.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_personal_details_view_model.dart';

class TrustedThirdPartyFormViewModel with ChangeNotifier, RootContextL10N, Logging {
  TrustedThirdPartyFormViewModel({required this.readPersonFromService}) : _patientDirectiveService = getIt.get() {
    personalDetailsFormViewModel =
        TrustedThirdPartyPersonalDetailsViewModel(personalDetails: personOfTrust.personalDetails);

    personalDetailsFormViewModel.addListener(_reactToPersonalDetailsChange);
  }

  PersonOfTrust get personOfTrust => readPersonFromService.call();

  late PersonalDetailsFormViewModel personalDetailsFormViewModel;

  final PatientDirectiveService _patientDirectiveService;

  final PersonOfTrust Function() readPersonFromService;

  String get agentLabel => l10n.personOfTrustAgent;

  String get guardianshipLabel => l10n.personOfTrustAgentGuardianship;

  bool get isAgentWithGuardianship => personOfTrust.guardianship;

  String get functionLabel => l10n.personOfTrustFunction;

  bool get showPowerSharingOptions => _patientDirectiveService.currentPatientDirective.personsOfTrust.length > 1;

  bool get hasIndividualPowerOfAttorney => personOfTrust.individualPowerOfAttorney;

  bool get hasGroupPowerOfAttorney => personOfTrust.groupPowerOfAttorney;

  String get hasIndividualPowerOfAttorneyLabel => l10n.personOfTrustAgentIndividualPower;

  String get hasGroupPowerOfAttorneyLabel => l10n.personOfTrustAgentGroupPower;

  String get powerSharingIntroductionLabel => l10n.personOfTrustAgentWithFunction;

  void _reactToPersonalDetailsChange() {
    personOfTrust.personalDetails = personalDetailsFormViewModel.personalDetails;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    personalDetailsFormViewModel.removeListener(_reactToPersonalDetailsChange);
    personalDetailsFormViewModel.dispose();
  }

  void toggleIsAgent() {
    personOfTrust.individualPowerOfAttorney = !personOfTrust.individualPowerOfAttorney;
    personOfTrust.groupPowerOfAttorney = false;

    notifyListeners();
  }

  void toggleHasGuardianship() {
    personOfTrust.guardianship = !personOfTrust.guardianship;
    notifyListeners();
  }

  void toggleIndividualPowerOfAttorney() {
    personOfTrust.individualPowerOfAttorney = !personOfTrust.individualPowerOfAttorney;
    personOfTrust.groupPowerOfAttorney = false;
    notifyListeners();
  }

  void toggleGroupPowerOfAttorney() {
    personOfTrust.groupPowerOfAttorney = !personOfTrust.groupPowerOfAttorney;
    personOfTrust.individualPowerOfAttorney = false;
    notifyListeners();
  }

  Future<void> removePersonOfTrust(BuildContext context) async {
    logger.d('call to removing person of trust $personOfTrust');

    final bool? shouldRemovePersonOfTrust = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.personOfTrustRemoveConfirmation),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false), child: Text(l10n.personOfTrustRemoveConfirmationNo)),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, true), child: Text(l10n.personOfTrustRemoveConfirmationYes))
            ],
          );
        });

    if (shouldRemovePersonOfTrust != null && shouldRemovePersonOfTrust) {
      final currentDirective = _patientDirectiveService.currentPatientDirective;

      final List<PersonOfTrust> personsInService = currentDirective.personsOfTrust;
      personsInService.remove(personOfTrust);
      _patientDirectiveService.currentPatientDirective = currentDirective;
    }
  }

  // ignore: avoid_positional_boolean_parameters
  String? isAgentWithGuardianshipValidator(bool? value) {
    if (!hasIndividualPowerOfAttorney && !hasGroupPowerOfAttorney && !isAgentWithGuardianship) {
      return l10n.personOfTrustValidationAgentAndGuardianshipEmpty;
    }
    return null;
  }

  // ignore: avoid_positional_boolean_parameters
  String? hasIndividualPowerOfAttorneyValidator(bool? value) {
    if (!hasIndividualPowerOfAttorney && !hasGroupPowerOfAttorney && !isAgentWithGuardianship) {
      return l10n.personOfTrustValidationAgentAndGuardianshipEmpty;
    }
    return null;
  }

  // ignore: avoid_positional_boolean_parameters
  String? hasGroupPowerOfAttorneyValidator(bool? value) {
    if (!hasIndividualPowerOfAttorney && !hasGroupPowerOfAttorney && !isAgentWithGuardianship) {
      return l10n.personOfTrustValidationAgentAndGuardianshipEmpty;
    }
    return null;
  }

  bool isInputValid() {
    return personalDetailsFormViewModel.isInputValid() &&
        hasIndividualPowerOfAttorneyValidator(hasIndividualPowerOfAttorney) == null &&
        hasGroupPowerOfAttorneyValidator(hasGroupPowerOfAttorney) == null &&
        isAgentWithGuardianshipValidator(isAgentWithGuardianship) == null;
  }
}
