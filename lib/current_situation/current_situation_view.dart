import 'package:flutter/material.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/current_situation/current_situation_view_model.dart';
import 'package:provider/provider.dart';

class CurrentSituation extends StatelessWidget {
  const CurrentSituation({Key? key}) : super(key: key);

  static Widget page() {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => CurrentSituationViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => CreationProcessNavigationViewModel(),
      )
    ], child: const CurrentSituation());
  }

  @override
  Widget build(BuildContext context) {
    final widget = Container();
    return CreationProcessNavigation(widget: widget);
  }
}
