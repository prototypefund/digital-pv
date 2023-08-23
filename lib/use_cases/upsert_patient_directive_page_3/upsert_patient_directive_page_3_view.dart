import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:pd_app/use_cases/upsert_patient_directive_page_3/upsert_patient_directive_page_3_view_model.dart';
import 'package:provider/provider.dart';

class UpsertPatientDirectivePage3View extends StatelessWidget {
  const UpsertPatientDirectivePage3View({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => UpsertPatientDirectivePage3ViewModel(), child: const UpsertPatientDirectivePage3View());
  }

  @override
  Widget build(BuildContext context) {
    final UpsertPatientDirectivePage3ViewModel viewModel = context.watch();
    return CreationProcessNavigation<UpsertPatientDirectivePage3ViewModel>(
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
            showCheckbox: false,
            height: 315,
            title: viewModel.cardOneText,
            description: viewModel.cardOneDescription,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          const SizedBox(height: 40),
          DPVWrappedBoxCheckbox(
            showCheckbox: false,
            height: 315,
            description: viewModel.cardTwoDescription,
            title: viewModel.cardTwoText,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
