import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/use_cases/add_positive_aspect/add_positive_aspect_view_model.dart';
import 'package:pd_app/use_cases/add_positive_aspect/new_positive_aspect_view_model.dart';
import 'package:provider/provider.dart';

class AddPositiveAspect extends StatefulWidget {
  const AddPositiveAspect({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => AddPositiveAspectViewModel(), child: const AddPositiveAspect());
  }

  @override
  State<AddPositiveAspect> createState() => _AddPositiveAspectState();
}

class _AddPositiveAspectState extends State<AddPositiveAspect> {
  @override
  Widget build(BuildContext context) {
    final AddPositiveAspectViewModel _viewModel = context.watch();

    return CreationProcessNavigation<AddPositiveAspectViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChangeNotifierProvider.value(
              value: _viewModel.newPositiveAspectViewModel, child: NewAspect<NewPositiveAspectViewModel>())
        ],
      ),
    );
  }
}
