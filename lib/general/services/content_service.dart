import 'package:flutter/foundation.dart';
import 'package:pd_app/general/dynamic_content/components/add_aspect_widget.dart';
import 'package:pd_app/general/dynamic_content/components/aspect_list_widget.dart';
import 'package:pd_app/general/dynamic_content/components/contextual_help.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/cms_content_definitions.dart';
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
import 'package:pd_app/general/dynamic_content/loading/cms_cache.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/logging.dart';

class ContentService with Logging, ChangeNotifier {
  ContentService({required this.locale}) : _cmsCache = getIt.get() {
    reloadContent();
  }

  final CMSCache _cmsCache;
  final String locale;

  List<AspectsExample> get positiveAspectsExamples {
    return _cmsCache
        .value<AspectsExample>(contentDefinition: CmsConfiguration.positiveAspectExamples, defaultValue: []);
  }

  List<AspectsExample> get negativeAspectsExamples {
    return _cmsCache
        .value<AspectsExample>(contentDefinition: CmsConfiguration.negativeAspectExamples, defaultValue: []);
  }

  List<AspectsExample> get futureSituationsExamples {
    return _cmsCache
        .value<AspectsExample>(contentDefinition: CmsConfiguration.futureSituationExamples, defaultValue: []);
  }

  List<TreatmentActivity> get treatmentActivities {
    return _cmsCache
        .value<TreatmentActivity>(contentDefinition: CmsConfiguration.treatmentActivities, defaultValue: []);
  }

  PositiveAspectsPage get positiveAspectsPage =>
      _cmsCache.value<PositiveAspectsPage>(contentDefinition: CmsConfiguration.positiveAspectPage, defaultValue: [
        PositiveAspectsPage(
            intro: null,
            outro: null,
            locale: locale,
            examplesTitle: '',
            aspectListWidget: AspectListWidget(
                deleteConfirmationQuestion: '',
                lowSignificanceLabel: '',
                highSignificanceLabel: '',
                deleteConfirmationCancel: '',
                deleteConfirmationConfirm: '',
                emptyListMessage: ''),
            addAspectWidget: AddAspectWidget(
                emptyTextFieldHint: '', lowSignificanceLabel: '', highSignificanceLabel: '', addAspectActionLabel: ''))
      ]).first;

  NegativeAspectsPage get negativeAspectsPage =>
      _cmsCache.value<NegativeAspectsPage>(contentDefinition: CmsConfiguration.negativeAspectsPage, defaultValue: [
        NegativeAspectsPage(
            intro: null,
            outro: null,
            locale: locale,
            examplesTitle: '',
            aspectListWidget: AspectListWidget(
                deleteConfirmationQuestion: '',
                lowSignificanceLabel: '',
                highSignificanceLabel: '',
                deleteConfirmationCancel: '',
                deleteConfirmationConfirm: '',
                emptyListMessage: ''),
            addAspectWidget: AddAspectWidget(
                emptyTextFieldHint: '', lowSignificanceLabel: '', highSignificanceLabel: '', addAspectActionLabel: ''))
      ]).first;

  FutureSituationsPage get futureSituationsPage =>
      _cmsCache.value<FutureSituationsPage>(contentDefinition: CmsConfiguration.futureSituationsPage, defaultValue: [
        FutureSituationsPage(
            intro: null,
            outro: null,
            locale: locale,
            treatmentActivitiesTitle: '',
            examplesTitle: '',
            aspectListWidget: AspectListWidget(
                deleteConfirmationQuestion: '',
                lowSignificanceLabel: '',
                highSignificanceLabel: '',
                deleteConfirmationCancel: '',
                deleteConfirmationConfirm: '',
                emptyListMessage: ''),
            addAspectWidget: AddAspectWidget(
                emptyTextFieldHint: '', lowSignificanceLabel: '', highSignificanceLabel: '', addAspectActionLabel: ''))
      ]).first;

  Onboarding get onboarding => _cmsCache.value<Onboarding>(
      contentDefinition: CmsConfiguration.onboarding,
      defaultValue: [Onboarding(skipLabel: '', pages: [], nextButtonLabel: '', callToActionLabel: '')]).first;

  TreatmentActivitiesPage get treatmentActivitiesPage => _cmsCache.value<TreatmentActivitiesPage>(
      contentDefinition: CmsConfiguration.treatmentActivitiesPage,
      defaultValue: [TreatmentActivitiesPage(intro: '', outro: '', treatmentActivitiesTitle: '')]).first;

  QualityOfLifePage get qualityOfLifePage =>
      _cmsCache.value<QualityOfLifePage>(contentDefinition: CmsConfiguration.qualityOfLifePage, defaultValue: [
        QualityOfLifePage(
            intro: '',
            outro: '',
            positiveQualityOfLifeExplanation: '',
            negativeQualityOfLifeExplanation: '',
            confirmationQuestion: '',
            confirmActionLabel: '')
      ]).first;

  TreatmentGoalPage get treatmentGoalPage =>
      _cmsCache.value<TreatmentGoalPage>(contentDefinition: CmsConfiguration.treatmentGoalPage, defaultValue: [
        TreatmentGoalPage(
            treatmentGoalCurativeQuestion: '',
            treatmentGoalPalliativeQuestion: '',
            adjustArrowExplanation: ContextualHelp(id: -1, title: '', content: ''),
            resetArrowActionLabel: '',
            curativeExplanation: ContextualHelp(id: -1, title: '', content: ''),
            palliativeExplanation: ContextualHelp(id: -1, title: '', content: ''),
            intro: '',
            confirmTreatmentGoalActionLabel: '')
      ]).first;

  GeneralInformationAboutDirectivePage get generalInformationAboutDirectivePage =>
      _cmsCache.value<GeneralInformationAboutDirectivePage>(
          contentDefinition: CmsConfiguration.generalInformationAboutDirectivePage,
          defaultValue: [GeneralInformationAboutDirectivePage(intro: '', confirmActionLabel: '')]).first;

  PersonalDetailsPage get personalDetailsPage => _cmsCache.value<PersonalDetailsPage>(
      contentDefinition: CmsConfiguration.personalDetailsPage,
      defaultValue: [PersonalDetailsPage(intro: '', downloadAsPdfActionLabel: '', showDirectiveActionLabel: '')]).first;

  @visibleForTesting
  Future<void> reloadContent() async {
    await _cmsCache.reloadAll(locale: locale);
    notifyListeners();
  }
}
