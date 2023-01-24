import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form.dart';
import 'package:pd_app/use_cases/personal_details/personal_details_view_model.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => PersonalDetailsViewModel(), child: const PersonalDetails());
  }

  @override
  Widget build(BuildContext context) {
    final PersonalDetailsViewModel _viewModel = context.watch();
    return CreationProcessNavigation<PersonalDetailsViewModel>(
        widget: Column(
      children: [
        MarkdownBody(content: _viewModel.introductionMarkdownContent),
        Form(
          autovalidateMode: AutovalidateMode.always,
          child: ChangeNotifierProvider.value(
            value: _viewModel.personalDetailsFormViewModel,
            child: PersonalDetailsForm(),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
            onPressed: _viewModel.downloadDirectiveAction(context), child: Text(_viewModel.downloadDirectiveLabel))
      ],
    ));
  }
}
