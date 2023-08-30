import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/circle_painer.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
import 'package:pd_app/general/view_components/webview_gauge_container.dart';
import 'package:pd_app/use_cases/general_treatment_activities/general_treatment_activities_view_model.dart';
import 'package:provider/provider.dart';

class TreatmentActivities extends StatefulWidget {
  const TreatmentActivities({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => GeneralTreatmentActivitiesViewModel(), child: const TreatmentActivities());
  }

  @override
  State<TreatmentActivities> createState() => _TreatmentActivitiesState();
}

class _TreatmentActivitiesState extends State<TreatmentActivities> with RootContextL10N {
  @override
  Widget build(BuildContext context) {
    final GeneralTreatmentActivitiesViewModel viewModel = context.watch();
    return CreationProcessNavigation<GeneralTreatmentActivitiesViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  left: 55.0,
                  child: CustomPaint(
                    painter: CirclePainter(strokeColor: DefaultThemeColors.blue),
                  )),
              buildText(viewModel.title, context),
            ],
          ),
          buildText(viewModel.subtopic, context),
          const SizedBox(height: 120),
          buildCenterText(viewModel.visualizationTitle, context),
          WebGaugeViewContainer(
            value: viewModel.isCurative ? 0.0 : 1.0,
          ),
          const SizedBox(height: 80),
          DPVWrappedBoxCheckbox(
            height: 288,
            showCheckbox: false,
            title: viewModel.situationsTitle,
            description: viewModel.situationsDescription,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            // value: viewModel.situationSelected,
            onChanged: (bool? value) {
              viewModel.situationSelected = !viewModel.situationSelected;
            },
          ),
          // const SizedBox(height: 40),
          // DPVWrappedBoxCheckbox(
          //   height: 288,
          //   description: viewModel.treatmentActivitiesDescription,
          //   title: viewModel.treatmentActivitiesTitle,
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   value: viewModel.treatmentActivitiesSelected,
          //   onChanged: (bool? value) {
          //     viewModel.treatmentActivitiesSelected = !viewModel.treatmentActivitiesSelected;
          //   },
          // ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
