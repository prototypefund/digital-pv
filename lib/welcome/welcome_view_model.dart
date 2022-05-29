import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/navigation/routes.dart';

class WelcomeViewModel with ChangeNotifier {
  final L10n l10n = GetIt.instance.get<L10n>();

  String get callToActionText {
    return l10n.createDigitalPatientDirective;
  }

  void onCallToActionPressed(BuildContext context) {
    context.push(Routes.positiveAspects);
  }
}
