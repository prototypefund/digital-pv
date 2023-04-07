import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/view_components/directive_visualization/aspect_positions.dart';
import 'package:pd_app/general/view_components/directive_visualization/sector.dart';
import 'package:pd_app/logging.dart';

class AspectsVisualization extends StatelessWidget with Logging {
  const AspectsVisualization(
      {required this.aspects,
      required this.angleForVisualisation,
      required this.activeAspectCircleGradient,
      required this.inactiveAspectCircleGradient,
      required this.onAspectTapped,
      required this.simulateFutureAspects});

  final List<Aspect> aspects;
  final double angleForVisualisation;
  final Gradient activeAspectCircleGradient;
  final Gradient inactiveAspectCircleGradient;
  final ValueChanged<Aspect> onAspectTapped;
  final bool simulateFutureAspects;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radiusScaleFactor = 2 * (constraints.maxWidth / Constraints.aspectVisualizationConstraints.maxWidth);

        final Sector aspectsSector = Sector(angle: angleForVisualisation, radius: constraints.maxWidth / 2);

        final List<AspectVisualizationInformation> aspectVisualizationInformation =
            AspectPositions(aspects: aspects, sector: aspectsSector, simulateFutureAspects: simulateFutureAspects)
                .listOfAspectVisualizationInformation;

        final List<Widget> aspectCircles = aspectVisualizationInformation.map(
          (visualInformation) {
            final size = (visualInformation.aspect.weight.value + 0.9) * 10 * radiusScaleFactor;
            final gradient = visualInformation.active ? activeAspectCircleGradient : inactiveAspectCircleGradient;

            return Positioned(
              left: visualInformation.coordinate.x - (size / 2) + constraints.maxWidth / 2,
              top: visualInformation.coordinate.y - (size / 2) + constraints.maxWidth / 2,
              width: size,
              height: size,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => onAspectTapped.call(visualInformation.aspect),
                  child: Tooltip(
                    message: visualInformation.aspect.name,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
                      child: const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList();

        return Stack(
          alignment: AlignmentDirectional.center,
          children: aspectCircles,
        );
      },
    );
  }
}
