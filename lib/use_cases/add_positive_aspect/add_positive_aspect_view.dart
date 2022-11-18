import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/dpv_slider.dart';
import 'package:pd_app/use_cases/add_positive_aspect/add_positive_aspect_view_model.dart';
import 'package:provider/provider.dart';

class AddPositiveAspect extends StatefulWidget {
  const AddPositiveAspect({super.key});

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => AddPositiveAspectViewModel(), child: const AddPositiveAspect());
  }

  @override
  State<AddPositiveAspect> createState() => _AddPositiveAspectState();
}

class _AddPositiveAspectState extends State<AddPositiveAspect> {
  @override
  Widget build(BuildContext context) {
    final AddPositiveAspectViewModel viewModel = context.watch();

    return CreationProcessNavigation<AddPositiveAspectViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Paddings.headlinePadding,
            child: Text(viewModel.addPositiveAspectTitle, style: Theme.of(context).textTheme.headlineLarge),
          ),
          Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Text(
              viewModel.addPositiveAspectExplanation,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Container(
            constraints: Constraints.textFieldConstraints,
            child: Padding(
              padding: Paddings.textFieldPadding,
              child: TextField(
                controller: viewModel.aspectTextFieldController,
                onChanged: (newValue) => setState(() {}),
                style: Theme.of(context).textTheme.labelLarge,
                decoration: InputDecoration(hintText: viewModel.addPositiveAspectTextfieldHint),
                autofocus: true,
              ),
            ),
          ),
          DPVSlider(
            sliderDescription: viewModel.aspectSignificanceLabel,
            showLabels: viewModel.showAspectSignificanceLabel,
            sliderLowLabel: viewModel.aspectsSignificanceLowLabel,
            sliderHighLabel: viewModel.aspectSignificanceHighLabel,
            value: viewModel.weight,
            padding: Paddings.newAspectSliderPadding,
            onChanged: (double value) {
              viewModel.weight = value;
            },
          ),
          Container(
            constraints: Constraints.formSaveActionConstraints,
            child: Padding(
              padding: Paddings.formSaveActionPadding,
              child: ElevatedButton(
                  onPressed: viewModel.addPositiveAspect(context), child: Text(viewModel.addPositiveAspectActionText)),
            ),
          ),
          Padding(
            padding: Paddings.subHeadlinePadding,
            child: Text(viewModel.examplesText, style: Theme.of(context).textTheme.headlineMedium),
          ),
          Container(
            constraints: Constraints.formSaveActionConstraints,
            child: Wrap(
              children: viewModel.examples
                  .map((example) => Padding(
                        padding: Paddings.exampleButtonPadding,
                        child: OutlinedButton(
                          onPressed: () => viewModel.chooseExample(example),
                          child: Text(example),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
