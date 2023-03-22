import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples.dart';
import 'package:pd_app/general/view_components/dpv_box.dart';
import 'package:pd_app/general/view_components/dpv_slider.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class NewAspect<ViewModelClass extends NewAspectViewModel> extends StatelessWidget with Logging {
  @override
  Widget build(BuildContext context) {
    final ViewModelClass viewModel = context.watch();

    return Column(
      children: [
        DPVBox(
          child: Column(
            children: [
              Padding(
                padding: Paddings.textFieldPadding,
                child: TextField(
                  controller: viewModel.aspectTextFieldController,
                  style: Theme.of(context).textTheme.labelLarge,
                  decoration: InputDecoration(hintText: viewModel.addAspectTextfieldHint),
                  autofocus: true,
                ),
              ),
              DPVSlider(
                sliderDescription: '',
                showLabels: false,
                sliderLowLabel: viewModel.aspectsSignificanceLowLabel,
                sliderHighLabel: viewModel.aspectSignificanceHighLabel,
                value: viewModel.weight,
                padding: Paddings.newAspectSliderPadding,
                onChanged: (double value) {
                  viewModel.weight = value;
                },
              ),
              ElevatedButton.icon(
                onPressed: viewModel.addAspect(context),
                icon: const Icon(Icons.add),
                label: Text(viewModel.addAspectActionText),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(viewModel.examplesTitle),
        const SizedBox(
          height: 10,
        ),
        Examples(
          examples: viewModel.examples,
          onExampleChosen: (String value) {
            viewModel.chooseExample(value);
          },
        ),
      ],
    );
  }
}
