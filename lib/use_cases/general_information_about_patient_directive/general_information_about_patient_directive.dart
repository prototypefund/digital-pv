import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/use_cases/general_information_about_patient_directive/general_information_about_patient_directive_view_model.dart';
import 'package:provider/provider.dart';

class GeneralInformationAboutPatientDirective extends StatelessWidget {
  const GeneralInformationAboutPatientDirective({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => GeneralInformationAboutPatientDirectiveViewModel(),
        child: const GeneralInformationAboutPatientDirective());
  }

  @override
  Widget build(BuildContext context) {
    final GeneralInformationAboutPatientDirectiveViewModel viewModel = context.watch();
    return CreationProcessNavigation<GeneralInformationAboutPatientDirectiveViewModel>(
        widget: Column(
      children: [
        MarkdownBody(content: viewModel.contentMarkdown),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () => viewModel.onConfirmPressed(context),
          child: Text(viewModel.confirmLabel),
        )
      ],
    ));
  }
}
