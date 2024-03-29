import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/view_components/dpv_box.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_form_view_model.dart';
import 'package:provider/provider.dart';

class TrustedThirdPartyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TrustedThirdPartyFormViewModel _viewModel = context.watch();

    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () async {
                    await _viewModel.removePersonOfTrust(context);
                  },
                  icon: const Icon(Icons.remove_circle_outline)),
            ],
          ),
          ChangeNotifierProvider.value(value: _viewModel.personalDetailsFormViewModel, child: PersonalDetailsForm()),
          Padding(
            padding: Paddings.trustedPersonPowerPadding,
            child: DPVBox(
                child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(_viewModel.functionLabel,
                      textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleMedium),
                ),
                if (!_viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.checkboxPadding,
                    child: CheckboxListTileFormField(
                      initialValue: _viewModel.hasIndividualPowerOfAttorney,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (_) {
                        _viewModel.toggleIndividualPowerOfAttorney();
                      },
                      title: Text(_viewModel.agentLabel),
                      validator: _viewModel.hasIndividualPowerOfAttorneyValidator,
                    ),
                  ),
                if (_viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.subHeadlinePadding,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(_viewModel.powerSharingIntroductionLabel,
                          textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                if (_viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.checkboxPadding + Paddings.groupPowerOfAttorneyCheckboxPadding,
                    child: CheckboxListTileFormField(
                      initialValue: _viewModel.hasIndividualPowerOfAttorney,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (_) {
                        _viewModel.toggleIndividualPowerOfAttorney();
                      },
                      validator: _viewModel.hasIndividualPowerOfAttorneyValidator,
                      title: Text(_viewModel.hasIndividualPowerOfAttorneyLabel),
                    ),
                  ),
                if (_viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.checkboxPadding + Paddings.groupPowerOfAttorneyCheckboxPadding,
                    child: CheckboxListTileFormField(
                      initialValue: _viewModel.hasGroupPowerOfAttorney,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (_) {
                        _viewModel.toggleGroupPowerOfAttorney();
                      },
                      validator: _viewModel.hasGroupPowerOfAttorneyValidator,
                      title: Text(_viewModel.hasGroupPowerOfAttorneyLabel),
                    ),
                  ),
                if (_viewModel.showPowerSharingOptions)
                  const SizedBox(
                    height: Sizes.checkboxGroupDistance,
                  ),
                Padding(
                  padding: Paddings.checkboxPadding,
                  child: CheckboxListTileFormField(
                    initialValue: _viewModel.isAgentWithGuardianship,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (_) {
                      _viewModel.toggleHasGuardianship();
                    },
                    title: Text(_viewModel.guardianshipLabel),
                    validator: _viewModel.isAgentWithGuardianshipValidator,
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
