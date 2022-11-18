import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/themes/themes.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/add_positive_aspect/add_positive_aspect_view.dart';
import 'package:pd_app/use_cases/evaluate_current_aspects/evaluate_current_aspects_view.dart';
import 'package:pd_app/use_cases/future_situations/future_situations.dart';
import 'package:pd_app/use_cases/general_information_about_patient_directive/general_information_about_patient_directive.dart';
import 'package:pd_app/use_cases/general_treatment_objective/general_treatment_objective.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_view.dart';
import 'package:pd_app/use_cases/personal_details/general_information_about_patient_directive.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view.dart';
import 'package:pd_app/use_cases/treatment_activities/treatment_activities.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party.dart';
import 'package:pd_app/use_cases/welcome/welcome_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PatientDirectiveApp extends StatefulWidget {
  const PatientDirectiveApp({super.key});

  @override
  State<PatientDirectiveApp> createState() => _PatientDirectiveAppState();
}

class _PatientDirectiveAppState extends State<PatientDirectiveApp> with Logging {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.welcome,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: WelcomeView.page()),
        ),
        GoRoute(
          path: Routes.positiveAspects,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: PositiveAspects.page()),
        ),
        GoRoute(
          path: Routes.addPositiveAspect,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: AddPositiveAspect.page()),
        ),
        GoRoute(
          path: Routes.negativeAspects,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: NegativeAspects.page()),
        ),
        GoRoute(
          path: Routes.evaluateCurrentAspects,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child: EvaluateCurrentAspects.page()),
        ),
        GoRoute(
          path: Routes.generalTreatmentObjective,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child: GeneralTreatmentObjective.page()),
        ),
        GoRoute(
          path: Routes.treatmentActivities,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: TreatmentActivities.page()),
        ),
        GoRoute(
          path: Routes.futureSituations,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: FutureSituations.page()),
        ),
        GoRoute(
          path: Routes.trustedThirdParty,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: TrustedThirdParty.page()),
        ),
        GoRoute(
          path: Routes.generalInformationAboutPatientDirective,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context, state: state, child: GeneralInformationAboutPatientDirective.page()),
        ),
        GoRoute(
          path: Routes.personalDetails,
          pageBuilder: (context, state) =>
              buildPageWithDefaultTransition<void>(context: context, state: state, child: PersonalDetails.page()),
        ),
      ],
      redirect: (_, __) => null,
    );
  }

  /// Helper to define the default transition to use
  ///
  /// GoRouter can only specify transition per Route, not globally (see https://stackoverflow.com/questions/71636397/set-default-transition-for-go-router-in-flutter)
  /// On Web, we want to have a different transition than on
  CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return NoTransitionPage<T>(
      key: state.pageKey,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          title: 'DPV',
          theme: Themes().defaultTheme,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          builder: (context, widget) {
            _injectL10nIntoGetIt(context);
            return widget ?? const SizedBox();
          },
        );
      },
    );
  }

  void _injectL10nIntoGetIt(BuildContext context) {
    final getIt = GetIt.instance;

    if (!getIt.isRegistered<L10n>()) {
      getIt.registerFactory(() => L10n.of(context));
    }
  }
}
