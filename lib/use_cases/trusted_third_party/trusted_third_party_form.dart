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
    final TrustedThirdPartyFormViewModel viewModel = context.watch();

    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () async {
                    await viewModel.removePersonOfTrust(context);
                  },
                  icon: const Icon(Icons.remove_circle_outline)),
            ],
          ),
          ChangeNotifierProvider.value(
            value: viewModel.personalDetailsFormViewModel,
            child: PersonalDetailsForm(),
          ),
          Padding(
            padding: Paddings.trustedPersonPowerPadding,
            child: DPVBox(
                child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(viewModel.functionLabel,
                      textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleMedium),
                ),
                if (!viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.checkboxPadding,
                    child: CheckboxListTileFormField(
                      initialValue: viewModel.hasIndividualPowerOfAttorney,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (_) {
                        viewModel.toggleIndividualPowerOfAttorney();
                      },
                      title: Text(viewModel.agentLabel),
                      validator: viewModel.hasIndividualPowerOfAttorneyValidator,
                    ),
                  ),
                if (viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.subHeadlinePadding,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(viewModel.powerSharingIntroductionLabel,
                          textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                if (viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.checkboxPadding + Paddings.groupPowerOfAttorneyCheckboxPadding,
                    child: CheckboxListTileFormField(
                      initialValue: viewModel.hasIndividualPowerOfAttorney,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (_) {
                        viewModel.toggleIndividualPowerOfAttorney();
                      },
                      validator: viewModel.hasIndividualPowerOfAttorneyValidator,
                      title: Text(viewModel.hasIndividualPowerOfAttorneyLabel),
                    ),
                  ),
                if (viewModel.showPowerSharingOptions)
                  Padding(
                    padding: Paddings.checkboxPadding + Paddings.groupPowerOfAttorneyCheckboxPadding,
                    child: CheckboxListTileFormField(
                      initialValue: viewModel.hasGroupPowerOfAttorney,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (_) {
                        viewModel.toggleGroupPowerOfAttorney();
                      },
                      validator: viewModel.hasGroupPowerOfAttorneyValidator,
                      title: Text(viewModel.hasGroupPowerOfAttorneyLabel),
                    ),
                  ),
                if (viewModel.showPowerSharingOptions)
                  const SizedBox(
                    height: Sizes.checkboxGroupDistance,
                  ),
                Padding(
                  padding: Paddings.checkboxPadding,
                  child: CheckboxListTileFormField(
                    initialValue: viewModel.isAgentWithGuardianship,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (_) {
                      viewModel.toggleHasGuardianship();
                    },
                    title: Text(viewModel.guardianshipLabel),
                    validator: viewModel.isAgentWithGuardianshipValidator,
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
