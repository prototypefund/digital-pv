import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

class DPVCheckboxCard extends StatefulWidget {
  const DPVCheckboxCard({
    this.checkboxOnly = false,
    this.onChanged,
    this.cardStateKey,
  }) : super(key: cardStateKey);

  final bool checkboxOnly;
  final GlobalKey<DPVCheckboxCardState>? cardStateKey;

  final Function(bool?)? onChanged;

  @override
  State<DPVCheckboxCard> createState() => DPVCheckboxCardState();
}

class DPVCheckboxCardState extends State<DPVCheckboxCard> {
  bool isHovered = false;
  late bool isChecked = false;

  void setChecked(bool value) {
    setState(() {
      isChecked = value;
    });
  }

  Widget checkbox() => _DPVCustomCheckbox(
        isChecked: isChecked,
        isHovered: isHovered,
        checkColor: Colors.white,
        onChanged: (bool? value) {
          widget.onChanged?.call(value);
          setState(() {
            isChecked = value!;
          });
        },
      );

  Widget checkboxCard() {
    return Container(
      width: 318,
      height: 58,
      decoration: BoxDecoration(
        color: DefaultThemeColors.lightWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _DPVCustomCheckbox(
              isChecked: isChecked,
              isHovered: isHovered,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            const SizedBox(width: 10),
            Text('YES', style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        hoverColor: Colors.transparent,
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
        },
        onHover: (value) {
          setState(() {
            isHovered = !isHovered;
          });
        },
        child: widget.checkboxOnly ? checkbox() : checkboxCard());
  }
}

class _DPVCustomCheckbox extends StatelessWidget {
  double get width => 35.0;
  double get height => 35.0;
  final Color? checkColor;
  final ValueChanged<bool>? onChanged;
  final bool isChecked;
  final bool isHovered;

  const _DPVCustomCheckbox({
    this.onChanged,
    this.checkColor,
    required this.isChecked,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(!isChecked);
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Color.fromRGBO(276, 276, 276, isHovered ? 0.3 : 0.1),
            width: 1.0,
          ),
          color: Colors.white,
        ),
        child: isChecked
            ? Padding(
                padding: const EdgeInsets.all(4.5),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Container(
                    decoration: const BoxDecoration(color: DefaultThemeColors.magenta, shape: BoxShape.circle),

                    // color: checkColor ?? Colors.blue,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
