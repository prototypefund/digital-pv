import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/dpv_dropdown.dart';
import 'package:pd_app/use_cases/general_treatment_activities/general_treatment_activities_view_model.dart';
import 'package:provider/provider.dart';

class TreatmentActivities extends StatefulWidget {
  const TreatmentActivities({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => TreatmentActivitiesViewModel(), child: const TreatmentActivities());
  }

  @override
  State<TreatmentActivities> createState() => _TreatmentActivitiesState();
}

class _TreatmentActivitiesState extends State<TreatmentActivities> with RootContextL10N {
  late TreatmentActivitiesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch();
    return CreationProcessNavigation<TreatmentActivitiesViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Paddings.headlinePadding,
            child: Text(_viewModel.addTreatmentActivitiesTitle, style: Theme.of(context).textTheme.headlineLarge),
          ),
          Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Text(
              _viewModel.addTreatmentActivitiesExplanation,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Center(
            child: Padding(
              padding: Paddings.headlineExplanationPadding,
              child: Center(
                child: Text(
                  _viewModel.addTreatmentActivitiesSubHeadline,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DPVDropDown<TreatmentActivity>(
              description: Text(_viewModel.addTreatmentActivitiesHospitalAdmission),
              initialValue: _viewModel.hospitalizationSelection,
              onChanged: (TreatmentActivity? value) {
                setState(() {
                  _viewModel.hospitalizationSelection = value;
                });
              },
              items: _viewModel.hospitalizationList.map<DropdownMenuItem<TreatmentActivity>>((TreatmentActivity value) {
                return DropdownMenuItem<TreatmentActivity>(
                  value: value,
                  child: Text(
                    value.localizedString(l10n),
                  ),
                );
              }).toList()),
          const SizedBox(
            height: 20,
          ),
          DPVDropDown<TreatmentActivity>(
              description: Text(_viewModel.addTreatmentActivitiesIntensiveTreatment),
              initialValue: _viewModel.intensiveTreatmentSelection,
              onChanged: (TreatmentActivity? value) {
                _viewModel.intensiveTreatmentSelection = value;
              },
              items:
                  _viewModel.intensiveTreatmentList.map<DropdownMenuItem<TreatmentActivity>>((TreatmentActivity value) {
                return DropdownMenuItem<TreatmentActivity>(
                  value: value,
                  child: Text(value.localizedString(l10n)),
                );
              }).toList()),
          const SizedBox(
            height: 20,
          ),
          DPVDropDown<TreatmentActivity>(
              description: Text(_viewModel.addTreatmentActivitiesResuscitation),
              initialValue: _viewModel.resuscitationSelection,
              onChanged: (TreatmentActivity? value) {
                setState(() {
                  _viewModel.resuscitationSelection = value;
                });
              },
              items: _viewModel.resuscitationList.map<DropdownMenuItem<TreatmentActivity>>((TreatmentActivity value) {
                return DropdownMenuItem<TreatmentActivity>(
                  value: value,
                  child: Text(value.localizedString(l10n)),
                );
              }).toList())
        ],
      ),
    );
  }
}
