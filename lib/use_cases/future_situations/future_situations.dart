import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';
import 'package:provider/provider.dart';

class FutureSituations extends StatelessWidget {
  const FutureSituations({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => FutureSituationsViewModel(),
        child: const FutureSituations());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<FutureSituationsViewModel>(
        widget: PatientDirectiveViewPlaceholder(title: 'Was wäre wenn?'));
  }
}
