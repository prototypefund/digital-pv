import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

class DPVButton extends StatelessWidget {
  const DPVButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.alignment = Alignment.center,
  });

  final String title;
  final VoidCallback onPressed;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: alignment,
        children: [
          ElevatedButton(
            // TODO: Should be shown, when the user presses proceed button

            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              // textStyle: MaterialStateProperty.resolveWith(
              //     (states) => Theme.of(context).textTheme.labelMedium!.copyWith(color: DefaultThemeColors.white)),
              // shadowColor: MaterialStateProperty.resolveWith((states) {
              //   return HSLColor.fromColor(DefaultThemeColors.magenta.withOpacity(0.5)).toColor();
              // }),
              elevation: 0,
              // overlayColor: MaterialStateProperty.resolveWith<Color?>(
              //   (Set<MaterialState> states) {
              //     if (states.contains(MaterialState.hovered)) return DefaultThemeColors.darkMagenta;
              //     return null;
              //   },
              // ),
            ).merge(
              ButtonStyle(
                textStyle: MaterialStateProperty.resolveWith(
                    (states) => Theme.of(context).textTheme.labelMedium!.copyWith(color: DefaultThemeColors.white)),
                // shadowColor: MaterialStateProperty.resolveWith((states) {
                //   return HSLColor.fromColor(DefaultThemeColors.magenta.withOpacity(0.5)).toColor();
                // }),
                // elevation: MaterialStateProperty.all(15),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) return DefaultThemeColors.darkMagenta;
                    return null;
                  },
                ),
              ),
            ),

            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(title,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: DefaultThemeColors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
