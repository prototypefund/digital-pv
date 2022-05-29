import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/evaluate_current_aspects/evaluate_current_aspects_view.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/navigation/routes.dart';
import 'package:pd_app/negative_aspects/negative_aspects_view.dart';
import 'package:pd_app/positive_aspects/positive_aspects_view.dart';
import 'package:pd_app/themes/default_theme.dart';
import 'package:pd_app/welcome/welcome_view.dart';

class PatientDirectiveApp extends StatefulWidget {
  const PatientDirectiveApp({Key? key}) : super(key: key);

  @override
  State<PatientDirectiveApp> createState() => _PatientDirectiveAppState();
}

class _PatientDirectiveAppState extends State<PatientDirectiveApp> with Logging, DefaultTheme {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
        routes: [
          GoRoute(
            path: Routes.welcome,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition(context: context, state: state, child: WelcomeView.page()),
          ),
          GoRoute(
            path: Routes.positiveAspects,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition(context: context, state: state, child: PositiveAspects.page()),
          ),
          GoRoute(
            path: Routes.negativeAspects,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition(context: context, state: state, child: NegativeAspects.page()),
          ),
          GoRoute(
            path: Routes.evaluateCurrentAspects,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition(context: context, state: state, child: EvaluateCurrentAspects.page()),
          ),
        ],
        redirect: (state) {
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
    required Widget child,
  }) {
    return NoTransitionPage<T>(
      key: state.pageKey,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'DPV',
      theme: defaultTheme,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      builder: (context, widget) {
        _injectL10nIntoGetIt(context);
        return widget ?? Container();
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
