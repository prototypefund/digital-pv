import 'package:json_annotation/json_annotation.dart';

part 'personal_details.g.dart';

@JsonSerializable()
class PersonalDetails {
  PersonalDetails();

  Map<String, dynamic> toJson() => _$PersonalDetailsToJson(this);

  factory PersonalDetails.fromJson(Map<String, dynamic> json) => _$PersonalDetailsFromJson(json);

  String? surname;
  String? name;
  String? dateOfBirth;
  String? address;
  String? zipCode;
  String? city;
  String? country;
  String? phone;
  String? email;
}
