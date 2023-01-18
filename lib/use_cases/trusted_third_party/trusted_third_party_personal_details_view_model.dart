import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';

class TrustedThirdPartyPersonalDetailsViewModel extends PersonalDetailsFormViewModel {
  TrustedThirdPartyPersonalDetailsViewModel({required super.personalDetails});

  @override
  String? surnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.personOfTrustValidationSurnameEmpty;
    }
    return super.surnameValidator(value);
  }

  @override
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.personOfTrustValidationNameEmpty;
    }
    return super.nameValidator(value);
  }

  @override
  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.personOfTrustValidationPhoneEmpty;
    }
    return super.phoneNumberValidator(value);
  }
}
