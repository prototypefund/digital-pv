import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class CreationProcessNavigationViewModel with ChangeNotifier {
  final L10n l10n = GetIt.instance.get<L10n>();

  String get nextButtonText {
    return l10n.navigationNext;
  }

  String get backButtonText {
    return l10n.navigationBack;
  }

  void onBackButtonPressed(BuildContext context) {
    context.pop();
  }

  void onNextButtonPressed(BuildContext context) {}

  bool get backButtonEnabled => true;

  bool get nextButtonEnabled => true;
}
