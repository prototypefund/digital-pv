import 'package:flutter/material.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/negative_aspects/negative_aspects_view_model.dart';
import 'package:pd_app/placeholder/patient_directive_view_placeholder.dart';
import 'package:provider/provider.dart';

class NegativeAspects extends StatelessWidget {
  const NegativeAspects({Key? key}) : super(key: key);

  static Widget page() {
    final negativeAspectsViewModel = NegativeAspectsViewModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: negativeAspectsViewModel),
      ChangeNotifierProvider<CreationProcessNavigationViewModel>.value(value: negativeAspectsViewModel)
    ], child: const NegativeAspects());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation(widget: PatientDirectiveViewPlaceholder(title: 'Negative Aspekte'));
  }
}
