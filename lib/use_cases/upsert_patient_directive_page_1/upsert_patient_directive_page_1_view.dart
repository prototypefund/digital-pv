import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/view_components/dpv_next_page_button.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:pd_app/use_cases/upsert_patient_directive_page_1/upsert_patient_directive_page_1_view_model.dart';
import 'package:provider/provider.dart';

class UpsertPatientDirectivePage1View extends StatelessWidget {
  const UpsertPatientDirectivePage1View({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => UpsertPatientDirectivePage1ViewModel(), child: const UpsertPatientDirectivePage1View());
  }

  @override
  Widget build(BuildContext context) {
    final UpsertPatientDirectivePage1ViewModel viewModel = context.watch();
    return CreationProcessNavigation<UpsertPatientDirectivePage1ViewModel>(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DPVWrappedBoxCheckbox(
                width: 300,
                height: 400,
                assetPath: viewModel.createPatientDirectiveAssetPath,
                title: viewModel.createPatientDirectiveTitle,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                value: viewModel.createPatientDirectiveIsSelected,
                onChanged: (bool? value) {
                  viewModel.createPatientDirectiveIsSelected = !viewModel.createPatientDirectiveIsSelected;
                },
              ),
              const SizedBox(width: 90),
              DPVWrappedBoxCheckbox(
                width: 300,
                height: 400,
                assetPath: viewModel.editPatientDirectiveAssetPath,
                title: viewModel.editPatientDirectiveTitle,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                value: viewModel.editPatientDirectiveIsSelected,
                onChanged: (bool? value) {
                  viewModel.editPatientDirectiveIsSelected = !viewModel.editPatientDirectiveIsSelected;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
