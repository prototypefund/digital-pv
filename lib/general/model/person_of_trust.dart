import 'package:pd_app/general/model/personal_details.dart';

class PersonOfTrust {
  PersonOfTrust(
      {this.individualPowerOfAttorney = false,
      this.groupPowerOfAttorney = false,
      this.agent = false,
      this.guardianship = false}) {
    personalDetails = PersonalDetails();
  }

  bool agent;
  bool guardianship;
  bool individualPowerOfAttorney;
  bool groupPowerOfAttorney;
  late PersonalDetails personalDetails;
}
