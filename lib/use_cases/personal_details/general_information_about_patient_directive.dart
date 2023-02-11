import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/services/pdf_service.dart';
import 'package:pd_app/use_cases/pdf/pdf_view_model.dart';
import 'package:pd_app/use_cases/personal_details/general_information_about_patient_directive_view_model.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => PersonalDetailsViewModel(), child: const PersonalDetails());
  }

  @override
  Widget build(BuildContext context) {
    // PLACEHOLDER PDF VIEWER
    final widget = FutureBuilder<Widget>(
      future: PdfService(PdfViewModel()).displayPdf(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 900, maxWidth: 1000), child: Center(child: snapshot.data));
          }
        }
      },
    );
    return CreationProcessNavigation<PersonalDetailsViewModel>(
      widget: widget,
    );
  }
}
