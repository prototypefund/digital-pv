// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalDetails _$PersonalDetailsFromJson(Map<String, dynamic> json) => PersonalDetails()
  ..surname = json['surname'] as String?
  ..name = json['name'] as String?
  ..dateOfBirth = json['dateOfBirth'] as String?
  ..address = json['address'] as String?
  ..zipCode = json['zipCode'] as String?
  ..city = json['city'] as String?
  ..country = json['country'] as String?
  ..phone = json['phone'] as String?
  ..email = json['email'] as String?;

Map<String, dynamic> _$PersonalDetailsToJson(PersonalDetails instance) => <String, dynamic>{
      'surname': instance.surname,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth,
      'address': instance.address,
      'zipCode': instance.zipCode,
      'city': instance.city,
      'country': instance.country,
      'phone': instance.phone,
      'email': instance.email,
    };
