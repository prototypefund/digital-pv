import 'package:flutter/material.dart';
import 'package:pd_app/general/view_components/navigation_drawer/drawer_view_model.dart';
import 'package:provider/provider.dart';

class DPVDrawer extends StatelessWidget {
  const DPVDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DrawerViewModel _viewModel = context.watch();

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              _viewModel.drawerTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: Text(_viewModel.saveDirectiveLabel, style: Theme.of(context).textTheme.titleMedium),
            onTap: () => _viewModel.onSaveDirectiveTapped(context),
          ),
          ListTile(
            title: Text(_viewModel.loadDirectiveLabel, style: Theme.of(context).textTheme.titleMedium),
            onTap: () => _viewModel.onLoadDirectiveTapped(context),
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }
}
