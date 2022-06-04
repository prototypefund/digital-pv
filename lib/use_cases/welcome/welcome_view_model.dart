import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/logging.dart';

class WelcomeViewModel with ChangeNotifier, Logging {
  final L10n l10n = GetIt.instance.get<L10n>();

  String get callToActionText {
    return l10n.createDigitalPatientDirective;
  }

  void onCallToActionPressed(BuildContext context) {
    logger.d('switching to positive aspects view');
    context.go(Routes.positiveAspects);
  }
}
