import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/extensions/dropdown_button_style.dart';

class DPVDropDown extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onChanged;
  final Widget description;
  final String initialValue;
  const DPVDropDown(
      {required this.options, required this.onChanged, required this.description, required this.initialValue});

  @override
  _DPVDropDownState createState() => _DPVDropDownState();
}

class _DPVDropDownState extends State<DPVDropDown> {
  String? _selectedValue;
  int? _selectedIndex;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    final DropdownButtonStyle? dropdownButtonStyle = Theme.of(context).extension();
    return GestureDetector(
      onTap: _toggleDropdown,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: widget.description),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                      child: Text(
                    _selectedValue != null ? "$_selectedIndex. $_selectedValue" : widget.initialValue,
                    style: dropdownButtonStyle?.textStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  )),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 34.0)
          ]),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final DropdownButtonStyle? dropdownButtonStyle = Theme.of(context).extension();
    return OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: size.width,
          child: Material(
            elevation: 4.0,
            child: ListView.separated(
              itemCount: widget.options.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                final option = widget.options[index];
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "${index + 1}. \t $option",
                      style: dropdownButtonStyle?.textStyle,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedValue = option;
                      _selectedIndex = index;
                      widget.onChanged(option);
                      _overlayEntry?.remove();
                      _overlayEntry = null;
                    });
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
