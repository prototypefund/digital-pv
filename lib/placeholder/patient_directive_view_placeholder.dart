import 'package:flutter/material.dart';

class PatientDirectiveViewPlaceholder extends StatelessWidget {
  const PatientDirectiveViewPlaceholder({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
