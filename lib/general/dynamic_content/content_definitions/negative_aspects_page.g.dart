// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'negative_aspects_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NegativeAspectsPage _$NegativeAspectsPageFromJson(Map<String, dynamic> json) => NegativeAspectsPage(
      intro: json['intro'] as String?,
      examplesTitle: json['examples_title'] as String,
      aspectListWidget: AspectListWidget.fromJson(json['aspectListWidget'] as Map<String, dynamic>),
      outro: json['outro'] as String?,
      locale: json['locale'] as String,
      addAspectWidget: AddAspectWidget.fromJson(json['addAspectWidget'] as Map<String, dynamic>),
      breadcrumbTitle: json['breadcrumbTitle'] as String,
    );

Map<String, dynamic> _$NegativeAspectsPageToJson(NegativeAspectsPage instance) => <String, dynamic>{
      'locale': instance.locale,
      'breadcrumbTitle': instance.breadcrumbTitle,
      'intro': instance.intro,
      'aspectListWidget': instance.aspectListWidget,
      'addAspectWidget': instance.addAspectWidget,
      'outro': instance.outro,
      'examples_title': instance.examplesTitle,
    };
