import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n_de.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_cache.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_loader.dart';
import 'package:pd_app/general/main_app/patient_directive_app.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

import 'mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final L10nDe l10n = L10nDe();
  late ContentService contentService;
  late MockCMSLoader mockCMSLoader;
  setUp(() async {
    HttpOverrides.global = null; // disable http clients for image fetching in markdown
    await GetIt.instance.reset();

    mockCMSLoader = MockCMSLoader();
    when(mockCMSLoader.loadEntitiesFromCMS(
            locale: anyNamed('locale'), contentDefinition: anyNamed('contentDefinition')))
        .thenThrow('test execution');

    GetIt.instance.registerSingleton(PatientDirectiveService());
    GetIt.instance.registerSingleton(l10n);
    GetIt.instance.registerSingleton<CMSLoader>(mockCMSLoader);
    GetIt.instance.registerSingleton(CMSCache(definitions: CmsConfiguration.definitions));
    contentService = ContentService(locale: l10n.localeName, loadOnlineContent: false);
    await contentService.reloadContent();
    GetIt.instance.registerSingleton(contentService);
  });

  testWidgets('Starts app with welcome view', (WidgetTester tester) async {
    await tester.pumpWidget(const PatientDirectiveApp());
  });

  testWidgets('Navigate through all screens with minimal input, and back', (WidgetTester tester) async {
    await tester.pumpWidget(PatientDirectiveApp(
      locale: Locale(l10n.localeName),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text(contentService.onboarding.nextButtonLabel));
    await tester.pumpAndSettle();
    await tester.tap(find.text(contentService.onboarding.nextButtonLabel));
    await tester.pumpAndSettle();
    await tester.tap(find.text(contentService.onboarding.nextButtonLabel));
    await tester.pumpAndSettle();

    await tester.tap(find.text(contentService.onboarding.callToActionLabel, skipOffstage: false));
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.positiveAspectsPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.positiveAspectsPage.outro),
        findsOneWidget);
    expect(find.text('Testen von Anwendungen', skipOffstage: false), findsNothing);

    //  add a new positive aspect
    expect(find.text(contentService.positiveAspectsPage.addAspectWidget.emptyTextFieldHint, skipOffstage: false),
        findsOneWidget);
    await tester.ensureVisible(find.text(contentService.positiveAspectsPage.addAspectWidget.emptyTextFieldHint));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Testen von Anwendungen');
    await tester.ensureVisible(find.text(contentService.positiveAspectsPage.addAspectWidget.addAspectActionLabel));
    await tester.pumpAndSettle();
    await tester.tap(find.text(contentService.positiveAspectsPage.addAspectWidget.addAspectActionLabel));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.negativeAspectsPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == (contentService.negativeAspectsPage.outro ?? '')),
        findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.qualityOfLifePage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == (contentService.qualityOfLifePage.outro ?? '')),
        findsOneWidget);

    await tester.ensureVisible(find.text(l10n.evaluateCurrentAspectsConfirm));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.evaluateCurrentAspectsConfirm));
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.treatmentGoalPage.intro),
        findsOneWidget);
    await tester.ensureVisible(find.text(contentService.treatmentGoalPage.confirmTreatmentGoalActionLabel));
    await tester.pumpAndSettle();
    await tester.tap(find.text(contentService.treatmentGoalPage.confirmTreatmentGoalActionLabel));
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.treatmentActivitiesPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is MarkdownBody && widget.content == (contentService.treatmentActivitiesPage.outro ?? '')),
        findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.futureSituationsPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == (contentService.futureSituationsPage.outro ?? '')),
        findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Meine Vertretungsperson/en (optional)"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text(contentService.generalInformationAboutDirectivePage.confirmActionLabel), findsOneWidget);
    await tester.ensureVisible(find.text(contentService.generalInformationAboutDirectivePage.confirmActionLabel));
    await tester.pumpAndSettle();
    await tester.tap(find.text(contentService.generalInformationAboutDirectivePage.confirmActionLabel));
    await tester.pumpAndSettle();

    expect(find.text(contentService.personalDetailsPage.downloadAsPdfActionLabel), findsAtLeastNWidgets(1));
    await tester.ensureVisible(find.text(contentService.personalDetailsPage.downloadAsPdfActionLabel).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(contentService.personalDetailsPage.downloadAsPdfActionLabel).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();

    expect(find.text(contentService.generalInformationAboutDirectivePage.confirmActionLabel), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Meine Vertretungsperson/en (optional)"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.futureSituationsPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == (contentService.futureSituationsPage.outro ?? '')),
        findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.treatmentActivitiesPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is MarkdownBody && widget.content == (contentService.treatmentActivitiesPage.outro ?? '')),
        findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.treatmentGoalPage.intro),
        findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.qualityOfLifePage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == (contentService.qualityOfLifePage.outro ?? '')),
        findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.negativeAspectsPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == (contentService.negativeAspectsPage.outro ?? '')),
        findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.positiveAspectsPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == (contentService.positiveAspectsPage.outro ?? '')),
        findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
  });
}
