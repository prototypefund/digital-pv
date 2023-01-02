import 'package:flutter/material.dart';

class DPVDropDown extends StatelessWidget {
  const DPVDropDown(
      {Key? key, required this.description, this.initialValue, required this.onChanged, required this.items})
      : super(key: key);

  final Widget description;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;

  @override
  Widget build(BuildContext context) {
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
          children: [
            description,
            const Spacer(),
            DropdownButton<String>(
              value: initialValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: onChanged,
              items: items,
            )
          ],
        ),
      ),
    );
  }
}
