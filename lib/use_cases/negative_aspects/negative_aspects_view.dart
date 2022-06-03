import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_view_model.dart';
import 'package:provider/provider.dart';

class NegativeAspects extends StatelessWidget {
  const NegativeAspects({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => NegativeAspectsViewModel(), child: const NegativeAspects());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<NegativeAspectsViewModel>(
        widget: PatientDirectiveViewPlaceholder(title: 'Negative Aspekte'));
  }
}
