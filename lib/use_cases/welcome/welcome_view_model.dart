import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_controller.dart';

class WelcomeViewModel with ChangeNotifier, Logging {
  WelcomeViewModel() {
    pageController.addListener(notifyListeners);
  }

  final L10n l10n = GetIt.instance.get<L10n>();
  final ContentService _contentService = GetIt.instance.get();

  final WelcomeViewPageController pageController = WelcomeViewPageController();

  String get callToActionText {
    return _contentService.onboarding.callToActionLabel;
  }

  String get nextButtonText => _contentService.onboarding.nextButtonLabel;

  String get skipButtonText => _contentService.onboarding.skipLabel;

  void onCallToActionPressed(BuildContext context) {
    logger.d('switching to positive aspects view');
    context.go(Routes.positiveAspects);
  }

  @override
  void dispose() {
    pageController.removeListener(notifyListeners);
    super.dispose();
  }
}
