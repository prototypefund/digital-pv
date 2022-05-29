import 'package:flutter/material.dart';

abstract class CreationProcessNavigationViewModel with ChangeNotifier {
  String get nextButtonText;

  String get backButtonText;

  void onBackButtonPressed(BuildContext context);

  void onNextButtonPressed(BuildContext context);

  bool get backButtonEnabled;

  bool get nextButtonEnabled;
}
