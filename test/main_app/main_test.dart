import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n_de.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:pd_app/general/dynamic_content/cms_cache.dart';
import 'package:pd_app/general/dynamic_content/cms_content_definitions.dart';
import 'package:pd_app/general/main_app/patient_directive_app.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/use_cases/welcome/welcome_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final L10nDe l10n = L10nDe();
  late ContentService contentService;
  setUp(() async {
    HttpOverrides.global = null; // disable http clients for image fetching in markdown
    await GetIt.instance.reset();
    GetIt.instance.registerSingleton(PatientDirectiveService());
    GetIt.instance.registerSingleton(l10n);
    GetIt.instance.registerSingleton(CMSCache(definitions: CmsContentDefinitions.definitions));
    contentService = ContentService(locale: l10n.localeName);
    await contentService.reloadContent();
    GetIt.instance.registerSingleton(contentService);
  });

  testWidgets('Starts app with welcome view', (WidgetTester tester) async {
    await tester.pumpWidget(const PatientDirectiveApp());

    expect(find.byType(WelcomeView), findsOneWidget);
  });

  testWidgets('Navigate through all screens with minimal input, and back', (WidgetTester tester) async {
    await tester.pumpWidget(const PatientDirectiveApp());
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeView), findsOneWidget);

    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.createDigitalPatientDirective, skipOffstage: false));
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

    await tester.ensureVisible(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();

    // go to add positive aspect and add a new one
    expect(find.text(l10n.addPositiveAspectTextFieldHint, skipOffstage: false), findsOneWidget);
    await tester.ensureVisible(find.text(l10n.addPositiveAspectTextFieldHint));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Testen von Anwendungen');
    await tester.ensureVisible(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();

    // go to add positive aspect and hit back button
    await tester.ensureVisible(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();

    // should still have exactly one entry of the new aspect
    expect(find.text('Testen von Anwendungen', skipOffstage: false), findsOneWidget);

    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Was bereitet mir Kummer?"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Meine Lebensqualität"), findsOneWidget);

    await tester.ensureVisible(find.text(l10n.evaluateCurrentAspectsConfirm));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.evaluateCurrentAspectsConfirm));
    await tester.pumpAndSettle();

    expect(find.text("Mein Behandlungsziel"), findsOneWidget);
    await tester.ensureVisible(find.text(l10n.generalTreatmentConfirm));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.generalTreatmentConfirm));
    await tester.pumpAndSettle();

    expect(find.text("Meine Behandlungswünsche"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Was wäre wenn?"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Meine Vertretungsperson/en (optional)"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text(l10n.generalInfoConfirm), findsOneWidget);
    await tester.ensureVisible(find.text(l10n.generalInfoConfirm));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.generalInfoConfirm));
    await tester.pumpAndSettle();

    expect(find.text(l10n.personalDetailsForDirectiveDownloadDirective), findsAtLeastNWidgets(1));
    await tester.ensureVisible(find.text(l10n.personalDetailsForDirectiveDownloadDirective).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.personalDetailsForDirectiveDownloadDirective).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();

    expect(find.text(l10n.generalInfoConfirm), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Meine Vertretungsperson/en (optional)"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Was wäre wenn?"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Meine Behandlungswünsche"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Mein Behandlungsziel"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Meine Lebensqualität"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Was bereitet mir Kummer?"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.positiveAspectsPage.intro),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is MarkdownBody && widget.content == contentService.positiveAspectsPage.outro),
        findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeView), findsOneWidget);
  });
}
