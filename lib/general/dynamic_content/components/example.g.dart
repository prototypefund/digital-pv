// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) => Example(
      id: json['id'] as int,
      group: json['group'] as String,
      title: json['title'] as String,
      contextualHelp: json['contextual_help'] == null
          ? null
          : ContextualHelp.fromJson(json['contextual_help'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'title': instance.title,
      'contextual_help': instance.contextualHelp,
    };
