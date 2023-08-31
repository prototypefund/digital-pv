import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form.dart';
import 'package:pd_app/use_cases/personal_details/personal_details_view_model.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
      create: (_) => PersonalDetailsViewModel(),
      child: const PersonalDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalDetailsViewModel viewModel = context.watch();
    return CreationProcessNavigation<PersonalDetailsViewModel>(
        widget: Column(
      children: [
        MarkdownBody(content: viewModel.introductionMarkdownContent),
        Form(
          autovalidateMode: AutovalidateMode.always,
          child: ChangeNotifierProvider.value(
            value: viewModel.personalDetailsFormViewModel,
            child: PersonalDetailsForm(navigationStep: viewModel.navigationStep),
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: viewModel.downloadDirectiveAction(context),
                child: Text(viewModel.downloadDirectiveLabel),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: viewModel.showDirectiveAction(context),
                child: Text(viewModel.showDirectiveLabel),
              )
            ],
          ),
        )
      ],
    ));
  }
}
