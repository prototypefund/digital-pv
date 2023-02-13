import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';

class DPVSlider extends StatelessWidget {
  const DPVSlider(
      {super.key,
      required this.sliderDescription,
      this.onChanged,
      this.onChangeEnd,
      required this.sliderLowLabel,
      required this.sliderHighLabel,
      required this.showLabels,
      required this.value,
      this.padding = Paddings.sliderPadding,
      this.constraints = Constraints.sliderConstraints});

  final String sliderDescription;
  final String sliderLowLabel;
  final String sliderHighLabel;
  final ValueChanged<double>? onChangeEnd;
  final ValueChanged<double>? onChanged;
  final double value;
  final bool showLabels;
  final EdgeInsets padding;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      padding: padding,
      child: Column(
        children: [
          if (showLabels)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  sliderDescription,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          Slider(
            value: value,
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  sliderLowLabel,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Flexible(
                child: Text(
                  sliderHighLabel,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
