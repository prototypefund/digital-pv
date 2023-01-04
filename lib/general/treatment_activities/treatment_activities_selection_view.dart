import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/dpv_dropdown.dart';
import 'package:provider/provider.dart';

class TreatmentActivitiesSelection extends StatelessWidget with RootContextL10N {
  @override
  Widget build(BuildContext context) {
    final TreatmentActivitiesSelectionViewModel _viewModel = context.watch();
    return Column(
      children: [
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
              _viewModel.hospitalizationSelection = value;
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
              _viewModel.resuscitationSelection = value;
            },
            items: _viewModel.resuscitationList.map<DropdownMenuItem<TreatmentActivity>>((TreatmentActivity value) {
              return DropdownMenuItem<TreatmentActivity>(
                value: value,
                child: Text(value.localizedString(l10n)),
              );
            }).toList())
      ],
    );
  }
}
