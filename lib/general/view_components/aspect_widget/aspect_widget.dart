import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/thresholds.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/dpv_box.dart';
import 'package:pd_app/general/view_components/dpv_slider.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situation_treatment_activities_selection_view_model.dart';
import 'package:provider/provider.dart';

class AspectWidget<AspectType extends Aspect> extends StatelessWidget with Logging {
  const AspectWidget(
      {super.key,
      required this.aspect,
      required this.sliderDescription,
      required this.sliderHighLabel,
      required this.sliderLowLabel,
      this.onRemove,
      this.onPositionChange});

  final AspectType aspect;

  final String sliderDescription;
  final String sliderLowLabel;
  final String sliderHighLabel;
  final VoidCallback? onRemove;
  final void Function(int oldIndex, int newIndex)? onPositionChange;

  @override
  Widget build(BuildContext context) {
    final AspectListViewModel viewModel = context.watch();
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width < Thresholds.futureSituationsTwoColumnDisplayThreshold) {
      return _buildSmallScreenVersion(context, viewModel);
    } else {
      return _buildLargeScreenVersion(context, viewModel);
    }
  }

  DPVBox _buildSmallScreenVersion(BuildContext context, AspectListViewModel viewModel) {
    return DPVBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSliderWithDescription(context: context, viewModel: viewModel),
          if (viewModel.showTreatmentOptions)
            _buildTreatmentOptionsWidget(context: context, viewModel: viewModel, aspect: aspect)
        ],
      ),
    );
  }

  DPVBox _buildLargeScreenVersion(BuildContext context, AspectListViewModel viewModel) {
    return DPVBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(flex: 5, child: _buildSliderWithDescription(context: context, viewModel: viewModel)),
          if (viewModel.showTreatmentOptions)
            const Flexible(
              flex: 1,
              child: SizedBox.shrink(),
            ),
          if (viewModel.showTreatmentOptions)
            Flexible(
                flex: 5, child: _buildTreatmentOptionsWidget(context: context, viewModel: viewModel, aspect: aspect))
        ],
      ),
    );
  }

  Widget _buildSliderWithDescription({required BuildContext context, required AspectListViewModel viewModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: Constraints.aspectTitleConstraints,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  aspect.name,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        final bool didRemove = await viewModel.removeAspect(context: context, aspect: aspect);
                        if (didRemove) {
                          onRemove?.call();
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline)),
                ],
              ),
            ],
          ),
        ),
        DPVSlider(
          sliderDescription: sliderDescription,
          showLabels: false,
          sliderLowLabel: sliderLowLabel,
          sliderHighLabel: sliderHighLabel,
          value: aspect.weight.value,
          onChangeEnd: (_) {
            final AspectPositionChange positionChange = viewModel.onAspectWeightAdjustmentDone(aspect: aspect);
            if (positionChange.oldIndex != positionChange.newIndex) {
              onPositionChange?.call(positionChange.oldIndex, positionChange.newIndex);
            }
          },
          onChanged: (double value) {
            viewModel.changeAspectWeight(aspect: aspect, weight: value);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: SwitchListTile(
                value: false,
                dense: true,
                contentPadding: EdgeInsets.zero,
                onChanged: (newValue) {},
                title: Text(viewModel.simulateLabel),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildTreatmentOptionsWidget(
      {required BuildContext context, required AspectListViewModel viewModel, required AspectType aspect}) {
    if (aspect is FutureSituation) {
      return ChangeNotifierProvider(
          create: (_) => FutureSituationTreatmentActivitiesSelectionViewModel(futureSituation: aspect),
          child: TreatmentActivitiesSelection<FutureSituationTreatmentActivitiesSelectionViewModel>());
    } else {
      return const SizedBox.shrink();
    }
  }
}
