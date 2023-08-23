import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/view_components/dpv_next_page_button.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:pd_app/use_cases/upsert_patient_directive_page_2/upsert_patient_directive_page_2_view_model.dart';
import 'package:provider/provider.dart';

class UpsertPatientDirectivePage2View extends StatelessWidget {
  const UpsertPatientDirectivePage2View({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => UpsertPatientDirectivePage2ViewModel(), child: const UpsertPatientDirectivePage2View());
  }

  @override
  Widget build(BuildContext context) {
    final UpsertPatientDirectivePage2ViewModel viewModel = context.watch();
    return CreationProcessNavigation<UpsertPatientDirectivePage2ViewModel>(
      widget: Column(
        children: [
          Center(
              child: Text(viewModel.subtitle,
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall)),
          const SizedBox(height: 80),
          Center(
              child: Text(viewModel.title,
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium)),
          const SizedBox(
            height: 60,
          ),
          DPVWrappedBoxCheckbox(
            height: 370,
            title: viewModel.createWithAccountPatientDirectiveTitle,
            description: viewModel.createWithAccountPatientDirectiveDescription,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: viewModel.createPatientDirectiveIsSelected,
            onChanged: (bool? value) {
              viewModel.createPatientDirectiveIsSelected = !viewModel.createPatientDirectiveIsSelected;
            },
          ),
          const SizedBox(height: 40),
          DPVWrappedBoxCheckbox(
            height: 370,
            description: viewModel.createWithoutAccountPatientDirectiveDescription,
            title: viewModel.createWithoutAccountPatientDirectiveTitle,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: viewModel.editPatientDirectiveIsSelected,
            onChanged: (bool? value) {
              viewModel.editPatientDirectiveIsSelected = !viewModel.editPatientDirectiveIsSelected;
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
