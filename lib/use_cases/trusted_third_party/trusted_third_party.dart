import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_view_model.dart';
import 'package:provider/provider.dart';

class TrustedThirdParty extends StatelessWidget {
  const TrustedThirdParty({Key? key}) : super(key: key);

  static Widget page() {
    final trustedThirdPartyViewModel = TrustedThirdPartyViewModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: trustedThirdPartyViewModel),
      ChangeNotifierProvider<CreationProcessNavigationViewModel>.value(value: trustedThirdPartyViewModel)
    ], child: const TrustedThirdParty());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation(widget: PatientDirectiveViewPlaceholder(title: 'Vertrauensperson'));
  }
}
