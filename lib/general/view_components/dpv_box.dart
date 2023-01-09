import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

class DPVBox extends StatelessWidget {
  const DPVBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: DefaultThemeColors.darkGreyTransparent,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(padding: const EdgeInsets.all(28.0), child: child));
  }
}
