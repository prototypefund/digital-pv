import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';

class PositiveAspects extends StatelessWidget {
  const PositiveAspects({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => PositiveAspectsViewModel(), child: const PositiveAspects());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<PositiveAspectsViewModel>(
        widget: PatientDirectiveViewPlaceholder(title: 'Positive Aspekte'));
  }
}
