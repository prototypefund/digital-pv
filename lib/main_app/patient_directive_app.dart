import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/current_situation/current_situation_view.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/navigation/routes.dart';
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
            path: Routes.root,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition(context: context, state: state, child: WelcomeView.page()),
          ),
          GoRoute(
            path: Routes.currentSituation,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition(context: context, state: state, child: CurrentSituation.page()),
          ),
        ],
        redirect: (state) {
          return null;
        });
  }

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
