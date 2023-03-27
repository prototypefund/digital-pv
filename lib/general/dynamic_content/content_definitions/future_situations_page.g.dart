// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_situations_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FutureSituationsPage _$FutureSituationsPageFromJson(Map<String, dynamic> json) => FutureSituationsPage(
      intro: json['intro'] as String?,
      treatmentActivitiesTitle: json['treatment_activities_title'] as String,
      examplesTitle: json['examples_title'] as String,
      aspectListWidget: AspectListWidget.fromJson(json['aspectListWidget'] as Map<String, dynamic>),
      outro: json['outro'] as String?,
      locale: json['locale'] as String,
      addAspectWidget: AddAspectWidget.fromJson(json['addAspectWidget'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FutureSituationsPageToJson(FutureSituationsPage instance) => <String, dynamic>{
      'locale': instance.locale,
      'intro': instance.intro,
      'aspectListWidget': instance.aspectListWidget,
      'addAspectWidget': instance.addAspectWidget,
      'outro': instance.outro,
      'treatment_activities_title': instance.treatmentActivitiesTitle,
      'examples_title': instance.examplesTitle,
    };
