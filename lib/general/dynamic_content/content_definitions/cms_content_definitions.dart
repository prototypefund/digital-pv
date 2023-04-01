import 'package:pd_app/general/dynamic_content/components/content_definition.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/future_situations_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/general_information_about_directive_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/negative_aspects_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/onboarding.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/personal_details_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/positive_aspects_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/quality_of_life_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activities_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_goal_page.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/trusted_third_party.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_config.dart';

mixin CmsConfiguration {
  static const String scheme = 'https';
  static const String host = 'strapi.dpv.staging.deyan7.de';
  static const int port = 443;

  // for development
  // static const String scheme = 'http';
  // static const String host = 'localhost';
  // static const int port = 1337;

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
      fieldsToPopulate: ["add_aspect_widget", "aspect_list_widget"],
      cmsLoadingFunction: (baseMap, attributesMap) => PositiveAspectsPage.fromCMSJson(attributesMap),
      localEntityName: 'positive-aspects-page',
      assetLoadingFunction: (json) => PositiveAspectsPage.fromJson(json),
      queryParameters: {});

  static ContentDefinition<NegativeAspectsPage> negativeAspectsPage = ContentDefinition<NegativeAspectsPage>(
      isSingleEntity: true,
      cmsEntityName: 'negative-aspects-page',
      fieldsToPopulate: ["add_aspect_widget", "aspect_list_widget"],
      cmsLoadingFunction: (baseMap, attributesMap) => NegativeAspectsPage.fromCMSJson(attributesMap),
      localEntityName: 'negative-aspects-page',
      assetLoadingFunction: (json) => NegativeAspectsPage.fromJson(json),
      queryParameters: {});

  static ContentDefinition<FutureSituationsPage> futureSituationsPage = ContentDefinition<FutureSituationsPage>(
      isSingleEntity: true,
      cmsEntityName: 'future-situations-page',
      fieldsToPopulate: ["add_aspect_widget", "aspect_list_widget"],
      cmsLoadingFunction: (baseMap, attributesMap) => FutureSituationsPage.fromCMSJson(attributesMap),
      localEntityName: 'future-situations-page',
      assetLoadingFunction: (json) => FutureSituationsPage.fromJson(json),
      queryParameters: {});

  static ContentDefinition<Onboarding> onboarding = ContentDefinition<Onboarding>(
      isSingleEntity: true,
      cmsEntityName: 'onboarding',
      fieldsToPopulate: ['pages', 'pages.logo'],
      cmsLoadingFunction: (baseMap, attributesMap) => Onboarding.fromCMSJson(attributesMap, cmsConfig: cmsConfig),
      localEntityName: 'onboarding',
      assetLoadingFunction: (json) => Onboarding.fromJson(json),
      queryParameters: {});

  static ContentDefinition<TreatmentActivity> treatmentActivities = ContentDefinition<TreatmentActivity>(
      isSingleEntity: false,
      cmsEntityName: 'treatment-activities',
      fieldsToPopulate: ['choices', 'default_value'],
      cmsLoadingFunction: (baseMap, attributesMap) => TreatmentActivity.fromCMSJson(baseMap, attributesMap),
      localEntityName: 'treatment-activites',
      assetLoadingFunction: (json) => TreatmentActivity.fromJson(json),
      queryParameters: {});

  static ContentDefinition<TreatmentActivitiesPage> treatmentActivitiesPage =
      ContentDefinition<TreatmentActivitiesPage>(
          isSingleEntity: true,
          cmsEntityName: 'treatment-activities-page',
          fieldsToPopulate: [],
          cmsLoadingFunction: (baseMap, attributesMap) => TreatmentActivitiesPage.fromCMSJson(attributesMap),
          localEntityName: 'treatment-activities-page',
          assetLoadingFunction: (json) => TreatmentActivitiesPage.fromJson(json),
          queryParameters: {});

  static ContentDefinition<QualityOfLifePage> qualityOfLifePage = ContentDefinition<QualityOfLifePage>(
      isSingleEntity: true,
      cmsEntityName: 'quality-of-life-page',
      fieldsToPopulate: [],
      cmsLoadingFunction: (baseMap, attributesMap) => QualityOfLifePage.fromCMSJson(attributesMap),
      localEntityName: 'quality-of-life-page',
      assetLoadingFunction: (json) => QualityOfLifePage.fromJson(json),
      queryParameters: {});

  static ContentDefinition<TreatmentGoalPage> treatmentGoalPage = ContentDefinition<TreatmentGoalPage>(
      isSingleEntity: true,
      cmsEntityName: 'treatment-goal-page',
      fieldsToPopulate: ["curative_explanation", "palliative_explanation", "adjust_arrow_explanation"],
      cmsLoadingFunction: (baseMap, attributesMap) => TreatmentGoalPage.fromCMSJson(attributesMap),
      localEntityName: 'treatment-goal-page',
      assetLoadingFunction: (json) => TreatmentGoalPage.fromJson(json),
      queryParameters: {});

  static ContentDefinition<GeneralInformationAboutDirectivePage> generalInformationAboutDirectivePage =
      ContentDefinition<GeneralInformationAboutDirectivePage>(
          isSingleEntity: true,
          cmsEntityName: 'general-information-about-directive-page',
          fieldsToPopulate: [],
          cmsLoadingFunction: (baseMap, attributesMap) =>
              GeneralInformationAboutDirectivePage.fromCMSJson(attributesMap),
          localEntityName: 'general-information-about-directive-page',
          assetLoadingFunction: (json) => GeneralInformationAboutDirectivePage.fromJson(json),
          queryParameters: {});

  static ContentDefinition<PersonalDetailsPage> personalDetailsPage = ContentDefinition<PersonalDetailsPage>(
      isSingleEntity: true,
      cmsEntityName: 'personal-details-page',
      fieldsToPopulate: [],
      cmsLoadingFunction: (baseMap, attributesMap) => PersonalDetailsPage.fromCMSJson(attributesMap),
      localEntityName: 'personal-details-page',
      assetLoadingFunction: (json) => PersonalDetailsPage.fromJson(json),
      queryParameters: {});

  static ContentDefinition<TrustedThirdPartyPage> trustedThirdPartyPage = ContentDefinition<TrustedThirdPartyPage>(
      isSingleEntity: true,
      cmsEntityName: 'trusted-third-party-page',
      fieldsToPopulate: [],
      cmsLoadingFunction: (baseMap, attributesMap) => TrustedThirdPartyPage.fromCMSJson(attributesMap),
      localEntityName: 'trusted-third-party-page',
      assetLoadingFunction: (json) => TrustedThirdPartyPage.fromJson(json),
      queryParameters: {});

  static List<ContentDefinition> definitions = [
    positiveAspectExamples,
    negativeAspectExamples,
    futureSituationExamples,
    positiveAspectPage,
    negativeAspectsPage,
    futureSituationsPage,
    treatmentActivities,
    onboarding,
    treatmentActivitiesPage,
    qualityOfLifePage,
    treatmentGoalPage,
    generalInformationAboutDirectivePage,
    personalDetailsPage,
    trustedThirdPartyPage
  ];
}
