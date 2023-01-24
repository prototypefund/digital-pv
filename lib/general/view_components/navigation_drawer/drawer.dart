import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class DPVDrawer extends StatelessWidget {
  const DPVDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              L10n.of(context).drawerTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: Text(L10n.of(context).drawerSaveDirective, style: Theme.of(context).textTheme.titleMedium),
            onTap: () {},
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }
}
