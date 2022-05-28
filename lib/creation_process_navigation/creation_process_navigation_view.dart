import 'package:flutter/material.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation extends StatelessWidget {
  const CreationProcessNavigation({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(
      create: (context) => CreationProcessNavigationViewModel(),
      child: const CreationProcessNavigation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Container());
  }
}
