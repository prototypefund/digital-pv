import 'package:flutter/material.dart';
import 'package:pd_app/general/view_components/dpv_checkbox_card.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';

class DPVCardWithCheckboxBelow extends StatefulWidget {
  final bool showCheckbox;
  final bool showCheckboxBelow;
  final EdgeInsets edgeInsets;
  final bool rightAlignCheckbox;
  final Widget? titleChild;
  final String title;
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final bool? value;
  final String? assetPath;
  final Function(bool?)? onChanged;
  final String? description;

  const DPVCardWithCheckboxBelow({
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
    this.value = false,
    this.onChanged,
  });

  @override
  State<DPVCardWithCheckboxBelow> createState() => _DPVCardWithCheckboxBelowState();
}

class _DPVCardWithCheckboxBelowState extends State<DPVCardWithCheckboxBelow> {
  bool _isChecked = false;
  late Function(bool?) _onChanged;
  final key = GlobalKey<DPVCheckboxCardState>();

  @override
  void initState() {
    super.initState();
    _onChanged = (value) {
      setState(() {
        _isChecked = value ?? false;
        widget.onChanged?.call(_isChecked);
        key.currentState?.setChecked(value ?? false);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DPVWrappedBoxCheckbox(
          blurRadius: 25,
          borderRadius: BorderRadius.circular(35),
          titleChild: widget.titleChild,
          assetPath: widget.assetPath,
          description: widget.description,
          showCheckbox: widget.showCheckbox,
          rightAlignCheckbox: widget.rightAlignCheckbox,
          edgeInsets: widget.edgeInsets,
          height: widget.height,
          width: widget.width,
          title: widget.title,
          padding: widget.padding,
          value: _isChecked,
          onChanged: _onChanged,
        ),
        const SizedBox(height: 10),
        if (widget.showCheckboxBelow)
          Center(
              child: DPVCheckboxCard(
            cardStateKey: key,
            onChanged: _onChanged,
            checkboxOnly: true,
          ))
      ],
    );
  }
}
