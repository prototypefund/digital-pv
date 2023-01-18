import 'package:flutter/material.dart';
import 'package:pd_app/general/view_components/dpv_box.dart';

/// a DPVBox containing a question and an explanation
class ExplanationBox extends StatelessWidget {
  const ExplanationBox({super.key, required this.title, required this.explanation});

  final String title;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return DPVBox(
        child: Column(
      children: [
        Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          explanation,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
