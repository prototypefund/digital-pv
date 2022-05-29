import 'package:flutter_test/flutter_test.dart';
import 'package:pd_app/general/main_app/patient_directive_app.dart';
import 'package:pd_app/use_cases/welcome/welcome_view.dart';

void main() {
  testWidgets('Starts app with welcome view', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PatientDirectiveApp());

    // Verify that our counter starts at 0.
    expect(find.byType(WelcomeView), findsOneWidget);
  });
}
