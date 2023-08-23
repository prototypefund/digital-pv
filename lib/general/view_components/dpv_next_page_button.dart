import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

class DPVNextPageButton extends StatelessWidget {
  const DPVNextPageButton(
      {super.key,
      required this.title,
      required this.canProceed,
      required this.onPressed,
      this.alignment = Alignment.center,
      this.inverted = false});

  final bool canProceed;
  final String title;
  final VoidCallback onPressed;
  final Alignment alignment;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800, minHeight: 50),
        child: Stack(
          fit: StackFit.expand,
          alignment: alignment,
          children: [
            AnimatedPositioned(
              top: canProceed ? 0.0 : 8.0,
              duration: const Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              child: ElevatedButton.icon(
                // TODO: Should be shown, when the user presses proceed button
                icon: CircularProgressIndicator(
                  color: Colors.white24.withOpacity(0),
                ),
                style: ButtonStyle(
                  side: inverted
                      ? MaterialStateProperty.all(
                          const BorderSide(width: 2.0, color: DefaultThemeColors.magenta),
                        )
                      : null,
                  backgroundColor: inverted ? MaterialStateProperty.all(DefaultThemeColors.white) : null,
                  textStyle: MaterialStateProperty.resolveWith(
                      (states) => Theme.of(context).textTheme.labelMedium!.copyWith(color: DefaultThemeColors.white)),
                  shadowColor: MaterialStateProperty.resolveWith((states) {
                    if (!canProceed) {
                      return Colors.transparent;
                    }
                    return inverted
                        ? DefaultThemeColors.darkWhite
                        : HSLColor.fromColor(DefaultThemeColors.magenta.withOpacity(0.5)).toColor();
                  }),
                  elevation: MaterialStateProperty.all(15),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return inverted ? DefaultThemeColors.lightWhite : DefaultThemeColors.darkMagenta;
                      }
                      return null;
                    },
                  ),
                ),
                onPressed: canProceed ? onPressed : null,
                label: Padding(
                  padding: EdgeInsets.fromLTRB(inverted ? 14 : 0.0, 14.0, 45.0, 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: inverted ? DefaultThemeColors.magenta : DefaultThemeColors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
