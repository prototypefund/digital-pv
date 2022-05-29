import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:provider/provider.dart';

import 'general_information_about_patient_directive_view_model.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  static Widget page() {
    final personalDetailsViewModel = PersonalDetailsViewModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: personalDetailsViewModel),
      ChangeNotifierProvider<CreationProcessNavigationViewModel>.value(value: personalDetailsViewModel)
    ], child: const PersonalDetails());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation(widget: PatientDirectiveViewPlaceholder(title: 'Persönliche Daten'));
  }
}
