// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aspect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aspect _$AspectFromJson(Map<String, dynamic> json) => Aspect(
      name: json['name'] as String,
      description: json['description'] as String?,
      weight: Weight.fromJson(json['weight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AspectToJson(Aspect instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
    };
