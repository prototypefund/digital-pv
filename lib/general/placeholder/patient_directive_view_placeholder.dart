import 'package:flutter/material.dart';
import 'package:pd_app/general/placeholder/placeholder_text.dart';

class PatientDirectiveViewPlaceholder extends StatelessWidget
    with PlaceholderText {
  const PatientDirectiveViewPlaceholder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            PlaceholderText.veryLongPlaceholderText,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
