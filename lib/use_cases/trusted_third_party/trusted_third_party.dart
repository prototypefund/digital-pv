import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/view_components/dpv_box.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_form.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_form_view_model.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_view_model.dart';
import 'package:provider/provider.dart';

class TrustedThirdParty extends StatelessWidget {
  const TrustedThirdParty({super.key});

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => TrustedThirdPartyViewModel(), child: const TrustedThirdParty());
  }

  @override
  Widget build(BuildContext context) {
    final TrustedThirdPartyViewModel viewModel = context.watch();
    return CreationProcessNavigation<TrustedThirdPartyViewModel>(
        widget: SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: Paddings.headlinePadding,
          child: Text(viewModel.headline, style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          viewModel.summary,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          viewModel.designatePersonLabel,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: Paddings.listPadding,
          child: ListView(
            shrinkWrap: true,
            children: viewModel.trustedPersonViewModels
                .map((trustedThirdPartyFormViewModel) =>
                    _buildPersonOfTrustForm(context: context, viewModel: trustedThirdPartyFormViewModel))
                .toList(),
          ),
        ),
        Padding(
          padding: Paddings.callToActionPadding,
          child: ElevatedButton(
              onPressed: () => viewModel.addPersonOfTrust(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(viewModel.addPersonOfTrustActionLabel),
                  const SizedBox(
                    width: Sizes.elevatedButtonLabelIconDistance,
                  ),
                  Icon(viewModel.addPersonOfTrustActionIcon)
                ],
              )),
        ),
      ]),
    ));
  }

  Widget _buildPersonOfTrustForm({required BuildContext context, required TrustedThirdPartyFormViewModel viewModel}) {
    return Padding(
        padding: Paddings.listElementPadding,
        child: DPVBox(
            child: ChangeNotifierProvider.value(
          value: viewModel,
          child: TrustedThirdPartyForm(),
        )));
  }
}
