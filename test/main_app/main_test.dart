import 'package:flutter_gen/gen_l10n/l10n_de.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:pd_app/general/main_app/patient_directive_app.dart';
import 'package:pd_app/use_cases/welcome/welcome_view.dart';

void main() {
  final L10nDe l10n = L10nDe();
  setUp(() {
    GetIt.instance.reset();
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

    expect(find.text("Positive Aspekte", skipOffstage: false), findsOneWidget);
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
    expect(find.text("Positive Aspekte", skipOffstage: false), findsOneWidget);

    await tester.tap(find.text(l10n.navigationBack));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeView), findsOneWidget);
  });
}
