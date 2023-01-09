import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/extensions/dropdown_button_style.dart';

class DPVDropDown<Type> extends StatelessWidget {
  const DPVDropDown(
      {Key? key, required this.description, this.initialValue, required this.onChanged, required this.items})
      : super(key: key);

  final Widget description;
  final Type? initialValue;
  final void Function(Type?)? onChanged;
  final List<DropdownMenuItem<Type>>? items;

  @override
  Widget build(BuildContext context) {
    final DropdownButtonStyle? dropdownButtonStyle = Theme.of(context).extension();
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(flex: 3, child: description),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 6,
              child: DropdownButton<Type>(
                isExpanded: true,
                value: initialValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: dropdownButtonStyle?.textStyle,
                underline: Container(
                  height: dropdownButtonStyle?.underlineHeight,
                  color: dropdownButtonStyle?.underlineColor,
                ),
                onChanged: onChanged,
                items: items,
              ),
            )
          ],
        ),
      ),
    );
  }
}
