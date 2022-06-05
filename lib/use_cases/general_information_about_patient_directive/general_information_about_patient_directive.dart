import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/general_information_about_patient_directive/general_information_about_patient_directive_view_model.dart';
import 'package:provider/provider.dart';

class GeneralInformationAboutPatientDirective extends StatelessWidget {
  const GeneralInformationAboutPatientDirective({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => GeneralInformationAboutPatientDirectiveViewModel(),
        child: const GeneralInformationAboutPatientDirective());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<GeneralInformationAboutPatientDirectiveViewModel>(
        widget: PatientDirectiveViewPlaceholder(title: 'Grundsätzliches zu meiner Patientenverfügung'));
  }
}
