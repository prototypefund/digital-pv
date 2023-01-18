import 'package:pd_app/general/model/personal_details.dart';

class PersonOfTrust {
  PersonOfTrust(
      {this.individualPowerOfAttorney = false, this.groupPowerOfAttorney = false, this.guardianship = false}) {
    personalDetails = PersonalDetails();
  }

  bool guardianship;
  bool individualPowerOfAttorney;
  bool groupPowerOfAttorney;
  late PersonalDetails personalDetails;
}
