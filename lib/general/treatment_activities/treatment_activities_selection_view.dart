import 'package:flutter/material.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/dpv_dropdown.dart';
import 'package:provider/provider.dart';

class TreatmentActivitiesSelection<ViewModelType extends TreatmentActivitiesSelectionViewModel> extends StatelessWidget
    with RootContextL10N {
  @override
  Widget build(BuildContext context) {
    final ViewModelType _viewModel = context.watch();
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
        DPVDropDown<TreatmentActivityChoice>(
            description: Text(
              _viewModel.addTreatmentActivitiesHospitalAdmission,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            initialValue: _viewModel.hospitalizationSelection,
            onChanged: (TreatmentActivityChoice? value) {
              final TreatmentActivityChoice newValue = value ?? TreatmentActivityChoice.notSpecified;
              _viewModel.hospitalizationSelection = newValue;
            },
            items: _viewModel.hospitalizationList
                .map<DropdownMenuItem<TreatmentActivityChoice>>((TreatmentActivityChoice value) {
              return DropdownMenuItem<TreatmentActivityChoice>(
                value: value,
                child: Text(
                  value.localizedString(l10n),
                ),
              );
            }).toList()),
        const SizedBox(
          height: 20,
        ),
        DPVDropDown<TreatmentActivityChoice>(
            description: Text(_viewModel.addTreatmentActivitiesIntensiveTreatment,
                style: Theme.of(context).textTheme.labelSmall),
            initialValue: _viewModel.intensiveTreatmentSelection,
            onChanged: (TreatmentActivityChoice? value) {
              final TreatmentActivityChoice newValue = value ?? TreatmentActivityChoice.notSpecified;
              _viewModel.intensiveTreatmentSelection = newValue;
            },
            items: _viewModel.intensiveTreatmentList
                .map<DropdownMenuItem<TreatmentActivityChoice>>((TreatmentActivityChoice value) {
              return DropdownMenuItem<TreatmentActivityChoice>(
                value: value,
                child: Text(value.localizedString(l10n)),
              );
            }).toList()),
        const SizedBox(
          height: 20,
        ),
        DPVDropDown<TreatmentActivityChoice>(
            description: Text(
              _viewModel.addTreatmentActivitiesResuscitation,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.left,
            ),
            initialValue: _viewModel.resuscitationSelection,
            onChanged: (TreatmentActivityChoice? value) {
              final TreatmentActivityChoice newValue = value ?? TreatmentActivityChoice.notSpecified;
              _viewModel.resuscitationSelection = newValue;
            },
            items: _viewModel.resuscitationList
                .map<DropdownMenuItem<TreatmentActivityChoice>>((TreatmentActivityChoice value) {
              return DropdownMenuItem<TreatmentActivityChoice>(
                value: value,
                child: Text(value.localizedString(l10n)),
              );
            }).toList())
      ],
    );
  }
}
