import 'package:flutter/material.dart';
import 'package:pd_app/general/view_components/dpv_checkbox_card.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:provider/provider.dart';

class CheckboxState extends ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void setChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}

class DPVCardWithCheckboxBelow extends StatelessWidget {
  final bool showCheckbox;
  final bool showCheckboxBelow;
  final EdgeInsets edgeInsets;
  final bool rightAlignCheckbox;
  final Widget? titleChild;
  final String title;
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final String? assetPath;
  final Function(bool?)? onChanged;
  final String? description;

  const DPVCardWithCheckboxBelow({
    super.key,
    this.titleChild,
    this.assetPath,
    this.description,
    this.showCheckbox = true,
    this.showCheckboxBelow = false,
    this.rightAlignCheckbox = false,
    this.edgeInsets = const EdgeInsets.only(top: 50, bottom: 50),
    this.height,
    this.width,
    required this.title,
    required this.padding,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DPVWrappedBoxCheckbox(
          blurRadius: 25,
          borderRadius: BorderRadius.circular(35),
          titleChild: titleChild,
          assetPath: assetPath,
          description: description,
          showCheckbox: showCheckbox,
          rightAlignCheckbox: rightAlignCheckbox,
          edgeInsets: edgeInsets,
          height: height,
          width: width,
          title: title,
          padding: padding,
          value: Provider.of<CheckboxState>(context).isChecked,
          onChanged: onChanged,
        ),
        const SizedBox(height: 10),
        if (showCheckboxBelow)
          Center(
              child: DPVCheckboxCard(
            isChecked: Provider.of<CheckboxState>(context).isChecked,
            onChanged: onChanged,
            checkboxOnly: true,
          ))
      ],
    );
  }
}
