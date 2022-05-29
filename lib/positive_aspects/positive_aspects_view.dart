import 'package:flutter/material.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';

class PositiveAspects extends StatelessWidget {
  const PositiveAspects({Key? key}) : super(key: key);

  static Widget page() {
    final positiveAspectsViewModel = PositiveAspectsViewModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: positiveAspectsViewModel),
      ChangeNotifierProvider<CreationProcessNavigationViewModel>.value(value: positiveAspectsViewModel)
    ], child: const PositiveAspects());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation(widget: PatientDirectiveViewPlaceholder(title: 'Positive Aspekte'));
  }
}
