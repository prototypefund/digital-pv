import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';

class PersonalDataForDirectiveViewModel extends PersonalDetailsFormViewModel {
  PersonalDataForDirectiveViewModel({required super.personalDetails});

  @override
  String? surnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.personalDetailsForDirectiveValidationSurnameEmpty;
    }
    return super.surnameValidator(value);
  }

  @override
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.personalDetailsForDirectiveValidationNameEmpty;
    }
    return super.nameValidator(value);
  }

  @override
  String? dateOfBirthValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.personalDetailsForDirectiveValidationDateOfBirthEmpty;
    }
    return super.dateOfBirthValidator(value);
  }
}
