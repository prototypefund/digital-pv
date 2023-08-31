import 'package:flutter/material.dart';
import 'package:pd_app/general/model/personal_details.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/logging.dart';

enum NavigationSubStep { name, address, contact }

class PersonalDetailsFormViewModel with ChangeNotifier, RootContextL10N, Logging {
  PersonalDetailsFormViewModel({required this.personalDetails}) {
    surnameTextFieldController.text = personalDetails.surname ?? '';
    surnameTextFieldController.addListener(_updatePersonalDetailsObject);

    nameTextFieldController.text = personalDetails.name ?? '';
    nameTextFieldController.addListener(_updatePersonalDetailsObject);

    dateOfBirthTextFieldController.text = personalDetails.dateOfBirth ?? '';
    dateOfBirthTextFieldController.addListener(_updatePersonalDetailsObject);

    addressTextFieldController.text = personalDetails.address ?? '';
    addressTextFieldController.addListener(_updatePersonalDetailsObject);

    zipCodeTextFieldController.text = personalDetails.zipCode ?? '';
    zipCodeTextFieldController.addListener(_updatePersonalDetailsObject);

    cityTextFieldController.text = personalDetails.city ?? '';
    cityTextFieldController.addListener(_updatePersonalDetailsObject);

    countryTextFieldController.text = personalDetails.country ?? '';
    countryTextFieldController.addListener(_updatePersonalDetailsObject);

    emailTextFieldController.text = personalDetails.email ?? '';
    emailTextFieldController.addListener(_updatePersonalDetailsObject);

    phoneTextFieldController.text = personalDetails.phone ?? '';
    phoneTextFieldController.addListener(_updatePersonalDetailsObject);
  }

  NavigationSubStep navigationStep = NavigationSubStep.name;

  PersonalDetails personalDetails;

  final TextEditingController surnameTextFieldController = TextEditingController();
  final TextEditingController nameTextFieldController = TextEditingController();
  final TextEditingController dateOfBirthTextFieldController = TextEditingController();
  final TextEditingController addressTextFieldController = TextEditingController();
  final TextEditingController zipCodeTextFieldController = TextEditingController();
  final TextEditingController cityTextFieldController = TextEditingController();
  final TextEditingController countryTextFieldController = TextEditingController();
  final TextEditingController emailTextFieldController = TextEditingController();
  final TextEditingController phoneTextFieldController = TextEditingController();

  String get surnameLabel => l10n.personDetailsSurname;

  String get nameLabel => l10n.personDetailsName;

  String get dateOfBirthLabel => l10n.personDetailsDateOfBirth;

  String get addressLabel => l10n.personDetailsAddress;

  String get zipCodeLabel => l10n.personDetailsZipCode;

  String get cityLabel => l10n.personDetailsCity;

  String get countryLabel => l10n.personDetailsCountry;

  String get emailLabel => l10n.personDetailsEmail;

  String get phoneLabel => l10n.personDetailsPhone;

  void _updatePersonalDetailsObject() {
    personalDetails.surname = surnameTextFieldController.text;
    personalDetails.name = nameTextFieldController.text;
    personalDetails.address = addressTextFieldController.text;
    personalDetails.dateOfBirth = dateOfBirthTextFieldController.text;
    personalDetails.email = emailTextFieldController.text;
    personalDetails.phone = phoneTextFieldController.text;
    personalDetails.zipCode = zipCodeTextFieldController.text;
    personalDetails.city = cityTextFieldController.text;
    personalDetails.country = countryTextFieldController.text;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    surnameTextFieldController.removeListener(_updatePersonalDetailsObject);
    nameTextFieldController.removeListener(_updatePersonalDetailsObject);
    dateOfBirthTextFieldController.removeListener(_updatePersonalDetailsObject);
    addressTextFieldController.removeListener(_updatePersonalDetailsObject);
    zipCodeTextFieldController.removeListener(_updatePersonalDetailsObject);
    cityTextFieldController.removeListener(_updatePersonalDetailsObject);
    countryTextFieldController.removeListener(_updatePersonalDetailsObject);
    emailTextFieldController.removeListener(_updatePersonalDetailsObject);
    phoneTextFieldController.removeListener(_updatePersonalDetailsObject);
  }

  String? phoneNumberValidator(String? value) => null;

  String? nameValidator(String? value) => null;

  String? surnameValidator(String? value) => null;

  String? dateOfBirthValidator(String? value) => null;

  bool isInputValid() {
    return phoneNumberValidator(personalDetails.phone) == null &&
        nameValidator(personalDetails.name) == null &&
        surnameValidator(personalDetails.surname) == null &&
        dateOfBirthValidator(personalDetails.dateOfBirth) == null;
  }
}
