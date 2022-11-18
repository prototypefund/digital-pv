import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/trusted_third_party/trusted_third_party_view_model.dart';
import 'package:provider/provider.dart';

class TrustedThirdParty extends StatelessWidget {
  const TrustedThirdParty({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => TrustedThirdPartyViewModel(),
        child: const TrustedThirdParty());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<TrustedThirdPartyViewModel>(
        widget: PatientDirectiveViewPlaceholder(title: 'Vertrauensperson'));
  }
}
