// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aspects_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AspectsExample _$AspectsExampleFromJson(Map<String, dynamic> json) => AspectsExample(
      example: Example.fromJson(json['example'] as Map<String, dynamic>),
      id: json['id'] as int,
      locale: json['locale'] as String,
    );

Map<String, dynamic> _$AspectsExampleToJson(AspectsExample instance) => <String, dynamic>{
      'example': instance.example,
      'id': instance.id,
      'locale': instance.locale,
    };
