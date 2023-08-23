import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pd_app/general/themes/colors.dart';

class _CustomBoxShadow extends BoxShadow {
  const _CustomBoxShadow({
    super.color,
    super.blurRadius,
    super.blurStyle = BlurStyle.normal,
  });

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}

class DPVWrappedBoxCheckbox extends StatelessWidget {
  final bool showCheckbox;
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
  final BorderRadius? borderRadius;
  final CrossAxisAlignment crossAxisAlignment;
  final double blurRadius;

  DPVWrappedBoxCheckbox(
      {super.key,
      this.titleChild,
      this.assetPath,
      this.description,
      this.showCheckbox = true,
      this.rightAlignCheckbox = false,
      this.edgeInsets = const EdgeInsets.only(top: 50, bottom: 50),
      this.height,
      this.width,
      required this.title,
      required this.padding,
      this.value = false,
      this.onChanged,
      this.blurRadius = 45,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      BorderRadius? borderRadius})
      : borderRadius = borderRadius ?? BorderRadius.circular(5);

  Widget buildCheckbox() => Transform.scale(
        scale: 2.5,
        child: Checkbox(
          checkColor: DefaultThemeColors.white,
          fillColor: MaterialStateProperty.resolveWith(
            (states) => DefaultThemeColors.lightMagenta,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(
            color: DefaultThemeColors.mediumGrey,
            width: 0.5,
          ),
          value: value,
          onChanged: (newValue) {
            onChanged?.call(newValue);
          },
        ),
      );

  Widget buildMainColumn(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (titleChild == null) const Spacer(),
          if (titleChild != null) titleChild!,
          if (titleChild == null)
            Text(
              title,
              softWrap: true,
              maxLines: 10,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          if (titleChild == null) const Spacer(),
          if (assetPath != null) ...[
            const Spacer(),
            SvgPicture.asset(
              assetPath!,
              colorFilter: ColorFilter.mode(DefaultThemeColors.mediumGrey, BlendMode.srcIn),
              height: 80,
              width: 80,
            ),
          ],
          if (showCheckbox && !rightAlignCheckbox) ...[const Spacer(), buildCheckbox(), const Spacer()],
        ],
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged != null && value != null ? onChanged!(!value!) : null,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            color: Colors.white10,
          ),
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border:
                Border.all(color: (value ?? false) ? DefaultThemeColors.veryDarkMagenta : DefaultThemeColors.darkWhite),
            boxShadow: [
              _CustomBoxShadow(
                  color: (value ?? false) ? DefaultThemeColors.veryDarkMagenta : DefaultThemeColors.lightGrey,
                  blurRadius: blurRadius,
                  blurStyle: BlurStyle.outer)
            ],
          ),
          padding: padding,
          child: Padding(
            padding: edgeInsets,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Expanded(child: buildMainColumn(context)),
                if (description != null)
                  const VerticalDivider(
                    width: 20,
                    thickness: 0.5,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.grey,
                  ),
                if (description != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MarkdownBody(
                        data: description!,
                      ),
                    ),
                  ),
                if (showCheckbox && rightAlignCheckbox)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15.0),
                    child: buildCheckbox(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
