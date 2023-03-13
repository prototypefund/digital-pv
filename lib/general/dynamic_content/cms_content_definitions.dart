import 'package:pd_app/general/dynamic_content/aspects_example.dart';
import 'package:pd_app/general/dynamic_content/components/content_definition.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_config.dart';
import 'package:pd_app/general/dynamic_content/onboarding.dart';
import 'package:pd_app/general/dynamic_content/positive_aspects_page.dart';

mixin CmsConfiguration {
  static const String scheme = 'https';
  static const String host = 'strapi.dpv.staging.deyan7.de';
  static const int port = 443;
  static const String cmsDirectoryPath = 'assets/cms/';

  static CmsConfig cmsConfig =
      CmsConfig(assetBasePath: cmsDirectoryPath, baseUri: Uri(scheme: scheme, host: host, port: port));
  static ContentDefinition<AspectsExample> positiveAspectExamples = ContentDefinition<AspectsExample>(
      isSingleEntity: false,
      cmsEntityName: 'aspect-examples',
      fieldsToPopulate: ['example', 'example.contextual_help'],
      cmsLoadingFunction: (baseMap, attributesMap) => AspectsExample.fromCMSJson(baseMap, attributesMap),
      localEntityName: 'positive-aspects-examples',
      assetLoadingFunction: (json) => AspectsExample.fromJson(json),
      queryParameters: {'filters[show_as_positive_aspect_example][\$eq]': 'true'});

  static ContentDefinition<AspectsExample> negativeAspectExamples = ContentDefinition<AspectsExample>(
      isSingleEntity: false,
      cmsEntityName: 'aspect-examples',
      fieldsToPopulate: ['example', 'example.contextual_help'],
      cmsLoadingFunction: (baseMap, attributesMap) => AspectsExample.fromCMSJson(baseMap, attributesMap),
      localEntityName: 'negative-aspects-examples',
      assetLoadingFunction: (json) => AspectsExample.fromJson(json),
      queryParameters: {'filters[show_as_negative_aspect_example][\$eq]': 'true'});

  static ContentDefinition<AspectsExample> futureSituationExamples = ContentDefinition<AspectsExample>(
      isSingleEntity: false,
      cmsEntityName: 'aspect-examples',
      fieldsToPopulate: ['example', 'example.contextual_help'],
      cmsLoadingFunction: (baseMap, attributesMap) => AspectsExample.fromCMSJson(baseMap, attributesMap),
      localEntityName: 'future-situations-examples',
      assetLoadingFunction: (json) => AspectsExample.fromJson(json),
      queryParameters: {'filters[show_as_future_situation_example][\$eq]': 'true'});

  static ContentDefinition<PositiveAspectsPage> positiveAspectPage = ContentDefinition<PositiveAspectsPage>(
      isSingleEntity: true,
      cmsEntityName: 'positive-aspects-page',
      fieldsToPopulate: [],
      cmsLoadingFunction: (baseMap, attributesMap) => PositiveAspectsPage.fromCMSJson(attributesMap),
      localEntityName: 'positive-aspects-page',
      assetLoadingFunction: (json) => PositiveAspectsPage.fromJson(json),
      queryParameters: {});

  static ContentDefinition<Onboarding> onboarding = ContentDefinition<Onboarding>(
      isSingleEntity: true,
      cmsEntityName: 'onboarding',
      fieldsToPopulate: ['pages', 'pages.logo'],
      cmsLoadingFunction: (baseMap, attributesMap) => Onboarding.fromCMSJson(attributesMap, cmsConfig: cmsConfig),
      localEntityName: 'onboarding',
      assetLoadingFunction: (json) => Onboarding.fromJson(json),
      queryParameters: {});

  static List<ContentDefinition> definitions = [
    positiveAspectExamples,
    negativeAspectExamples,
    futureSituationExamples,
    positiveAspectPage,
    onboarding
  ];
}
