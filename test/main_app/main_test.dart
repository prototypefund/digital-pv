import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n_de.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:pd_app/general/main_app/patient_directive_app.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/use_cases/welcome/welcome_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final L10nDe l10n = L10nDe();
  setUp(() {
    GetIt.instance.reset();
    GetIt.instance.registerSingleton(PatientDirectiveService());
    GetIt.instance.registerSingleton(l10n);
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

    expect(find.text(l10n.positiveAspectsHeadline, skipOffstage: false), findsOneWidget);
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

    // verify new aspect is on page
    expect(find.text(l10n.positiveAspectsHeadline, skipOffstage: false), findsOneWidget);
    expect(find.text('Testen von Anwendungen', skipOffstage: false), findsOneWidget);

    // go to add positive aspect and hit back button
    await tester.ensureVisible(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.addPositiveAspectCallToAction));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();

    // should still have exactly one entry of the new aspect
    expect(find.text(l10n.positiveAspectsHeadline, skipOffstage: false), findsOneWidget);
    expect(find.text('Testen von Anwendungen', skipOffstage: false), findsOneWidget);

    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Negative Aspekte"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Aspekte evaluieren"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Behandlungsziel festlegen"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Behandlungsmaßnahmen festlegen"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Was wäre wenn?"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Vertrauensperson"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Grundsätzliches zu meiner Patientenverfügung"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    expect(find.text("Persönliche Daten"), findsOneWidget);
    await tester.tap(find.text(l10n.navigationNext));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Grundsätzliches zu meiner Patientenverfügung"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Vertrauensperson"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Was wäre wenn?"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Behandlungsmaßnahmen festlegen"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Behandlungsziel festlegen"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Aspekte evaluieren"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text("Negative Aspekte"), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.text(l10n.positiveAspectsHeadline, skipOffstage: false), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeView), findsOneWidget);
  });
}
