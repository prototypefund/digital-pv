import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/placeholder/placeholder_text.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Can display large content without RenderFlex exception', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<CreationProcessNavigationViewModel>(
            create: (_) => StubCreationProcessNavigationViewModel(),
            child: CreationProcessNavigation(
                widget: Column(
              children: [
                Center(
                  child: Text(PlaceholderText.veryLongPlaceholderText),
                ),
              ],
            )))));

    // Verify that our counter starts at 0.
    expect(find.byType(CreationProcessNavigation), findsOneWidget);
  });
}

class StubCreationProcessNavigationViewModel with ChangeNotifier implements CreationProcessNavigationViewModel {
  @override
  bool get backButtonEnabled => false;

  @override
  String get backButtonText => 'Back';

  @override
  bool get nextButtonEnabled => false;

  @override
  String get nextButtonText => 'Next';

  @override
  void onBackButtonPressed(BuildContext context) {}

  @override
  void onNextButtonPressed(BuildContext context) {}
}
