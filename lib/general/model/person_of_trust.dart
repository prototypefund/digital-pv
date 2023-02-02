import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/model/personal_details.dart';

part 'person_of_trust.g.dart';

@JsonSerializable()
class PersonOfTrust {
  PersonOfTrust(
      {this.individualPowerOfAttorney = false, this.groupPowerOfAttorney = false, this.guardianship = false}) {
    personalDetails = PersonalDetails();
  }

  factory PersonOfTrust.fromJson(Map<String, dynamic> json) => _$PersonOfTrustFromJson(json);

  bool guardianship;
  bool individualPowerOfAttorney;
  bool groupPowerOfAttorney;
  late PersonalDetails personalDetails;

  Map<String, dynamic> toJson() => _$PersonOfTrustToJson(this);
}
