import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/personal_details/personal_details_view_model.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => PersonalDetailsViewModel(), child: const PersonalDetails());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<PersonalDetailsViewModel>(
        widget: PatientDirectiveViewPlaceholder(title: 'Persönliche Daten'));
  }
}
