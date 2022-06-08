import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/use_cases/add_positive_aspect/add_positive_aspect_view_model.dart';
import 'package:provider/provider.dart';

class AddPositiveAspect extends StatelessWidget {
  const AddPositiveAspect({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => AddPositiveAspectViewModel(), child: const AddPositiveAspect());
  }

  @override
  Widget build(BuildContext context) {
    final AddPositiveAspectViewModel _viewModel = context.watch();

    return CreationProcessNavigation<AddPositiveAspectViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Paddings.headlinePadding,
            child: Text('Aspekt hinzufügen', style: Theme.of(context).textTheme.headlineLarge),
          ),
          Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Text(
              'Beschreiben Sie einen Aspekt aus Ihrem Leben, der Ihnen aktuell Freude macht',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Container(
            constraints: Constraints.textFieldConstraints,
            child: Padding(
              padding: Paddings.textFieldPadding,
              child: TextField(
                style: Theme.of(context).textTheme.labelLarge,
                decoration: InputDecoration(hintText: _viewModel.addPositiveAspectTextfieldHint),
                autofocus: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
