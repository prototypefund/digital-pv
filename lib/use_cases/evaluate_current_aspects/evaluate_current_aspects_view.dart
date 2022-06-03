import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/evaluate_current_aspects/evaluate_current_aspects_view_model.dart';
import 'package:provider/provider.dart';

class EvaluateCurrentAspects extends StatelessWidget {
  const EvaluateCurrentAspects({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => EvaluateCurrentAspectsViewModel(), child: const EvaluateCurrentAspects());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<EvaluateCurrentAspectsViewModel>(
        widget: PatientDirectiveViewPlaceholder(title: 'Aspekte evaluieren'));
  }
}
