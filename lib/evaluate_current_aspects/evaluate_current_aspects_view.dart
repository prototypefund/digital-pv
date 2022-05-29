import 'package:flutter/material.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';

class EvaluateCurrentAspects extends StatelessWidget {
  const EvaluateCurrentAspects({Key? key}) : super(key: key);

  static Widget page() {
    final evaluateCurrentAspectsViewModel = EvaluateCurrentAspectsViewModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: evaluateCurrentAspectsViewModel),
      ChangeNotifierProvider<CreationProcessNavigationViewModel>.value(value: evaluateCurrentAspectsViewModel)
    ], child: const EvaluateCurrentAspects());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation(widget: PatientDirectiveViewPlaceholder(title: 'Aspekte evaluieren'));
  }
}
