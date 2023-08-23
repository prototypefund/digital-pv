import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/themes/themes.dart';
import 'package:pd_app/general/utils/custom_browser_scroll_behavior.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/evaluate_current_aspects/evaluate_current_aspects_view.dart';
import 'package:pd_app/use_cases/future_situations/future_situations.dart';
import 'package:pd_app/use_cases/general_information_about_patient_directive/general_information_about_patient_directive.dart';
import 'package:pd_app/use_cases/general_treatment_activities/general_treatment_activities.dart';
import 'package:pd_app/use_cases/general_treatment_objective/general_treatment_objective.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_view.dart';
import 'package:pd_app/use_cases/pdf/directive_pdf_view.dart';
import 'package:pd_app/use_cases/personal_details/personal_details.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party.dart';

final GlobalKey<ScaffoldMessengerState> _navigatorKey = GlobalKey<ScaffoldMessengerState>();

class PatientDirectiveApp extends StatefulWidget {
  const PatientDirectiveApp({super.key, this.locale});

  @override
  State<PatientDirectiveApp> createState() => _PatientDirectiveAppState();

  final Locale? locale;
}

class _PatientDirectiveAppState extends State<PatientDirectiveApp> with Logging {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
        initialLocation: Routes.positiveAspects.path,
        routes: [
          // GoRoute(
          //   path: Routes.welcome.path,
          //   pageBuilder: (context, state) =>
          //       buildPageWithDefaultTransition<WelcomeView>(context: context, state: state, child: WelcomeView.page()),
          // ),
          GoRoute(
            path: Routes.positiveAspects.path,
            pageBuilder: (context, state) {
              final Uri uri = state.uri;
              final Map<String, String> queryParams = uri.queryParameters;
              final String? focusSituationName = queryParams[focusParam];
              final PatientDirectiveService directiveService = getIt.get();
              final focusSituation =
                  directiveService.currentPatientDirective.findPositiveAspect(name: focusSituationName);
              return buildPageWithDefaultTransition<PositiveAspects>(
                  key: ValueKey('positive-aspect-$focusSituationName'),
                  context: context,
                  state: state,
                  child: PositiveAspects.page(focusAspect: focusSituation));
            },
          ),
          GoRoute(
            path: Routes.negativeAspects.path,
            pageBuilder: (context, state) {
              final Uri uri = state.uri;
              final Map<String, String> queryParams = uri.queryParameters;
              final String? focusSituationName = queryParams[focusParam];
              final PatientDirectiveService directiveService = getIt.get();
              final focusSituation =
                  directiveService.currentPatientDirective.findNegativeAspect(name: focusSituationName);

              return buildPageWithDefaultTransition<NegativeAspects>(
                  key: ValueKey('negative-aspect-$focusSituationName'),
                  context: context,
                  state: state,
                  child: NegativeAspects.page(focusAspect: focusSituation));
            },
          ),
          GoRoute(
            path: Routes.evaluateCurrentAspects.path,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<EvaluateCurrentAspects>(
                context: context, state: state, child: EvaluateCurrentAspects.page()),
          ),
          GoRoute(
            path: Routes.generalTreatmentObjective.path,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<GeneralTreatmentObjective>(
                context: context, state: state, child: GeneralTreatmentObjective.page()),
          ),
          GoRoute(
            path: Routes.treatmentActivities.path,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<TreatmentActivities>(
                context: context, state: state, child: TreatmentActivities.page()),
          ),
          GoRoute(
            path: Routes.futureSituations.path,
            pageBuilder: (context, state) {
              final Uri uri = state.uri;
              final Map<String, String> queryParams = uri.queryParameters;
              final String? focusSituationName = queryParams[focusParam];

              final PatientDirectiveService directiveService = getIt.get();
              final focusSituation =
                  directiveService.currentPatientDirective.findFutureSituation(name: focusSituationName);
              return buildPageWithDefaultTransition<FutureSituations>(
                  key: ValueKey('future-situation-$focusSituationName'),
                  context: context,
                  state: state,
                  child: FutureSituations.page(focusAspect: focusSituation));
            },
          ),
          GoRoute(
            path: Routes.trustedThirdParty.path,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<TrustedThirdParty>(
                context: context, state: state, child: TrustedThirdParty.page()),
          ),
          GoRoute(
            path: Routes.generalInformationAboutPatientDirective.path,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<GeneralInformationAboutPatientDirective>(
                context: context, state: state, child: GeneralInformationAboutPatientDirective.page()),
          ),
          GoRoute(
            path: Routes.personalDetails.path,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<PersonalDetails>(
                context: context, state: state, child: PersonalDetails.page()),
          ),
          GoRoute(
            path: Routes.pdf.path,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<DirectivePdfView>(
                context: context, state: state, child: DirectivePdfView()),
          ),
        ],
        redirect: (context, state) {
          return null;
        });
  }

  /// Helper to define the default transition to use
  ///
  /// GoRouter can only specify transition per Route, not globally (see https://stackoverflow.com/questions/71636397/set-default-transition-for-go-router-in-flutter)
  /// On Web, we want to have a different transition than on
  CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    LocalKey? key,
    required Widget child,
  }) {
    return NoTransitionPage<T>(
      key: key ?? state.pageKey,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: CustomBrowserScrollBehavior(),
      scaffoldMessengerKey: _navigatorKey,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'DPV',
      theme: Themes().defaultTheme,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: widget.locale,
      builder: (_, widget) {
        _injectL10nIntoGetIt(_navigatorKey.currentState!.context);
        return widget ?? const SizedBox();
      },
    );
  }

  void _injectL10nIntoGetIt(BuildContext context) {
    final getIt = GetIt.instance;

    if (!getIt.isRegistered<L10n>()) {
      getIt.registerFactory(() => L10n.of(context));
    }
    if (!getIt.isRegistered<ContentService>()) {
      getIt.registerSingleton(ContentService(locale: L10n.of(context).localeName));
    }
  }
}
