import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/view_components/directive_visualization/aspect_positions.dart';
import 'package:pd_app/general/view_components/directive_visualization/sector.dart';
import 'package:pd_app/logging.dart';

class AspectsVisualization extends StatelessWidget with Logging {
  const AspectsVisualization({
    required this.aspects,
    required this.angleForVisualisation,
    required this.activeAspectCircleGradient,
    required this.inactiveAspectCircleGradient,
  });

  final List<Aspect> aspects;
  final double angleForVisualisation;
  final Gradient activeAspectCircleGradient;
  final Gradient inactiveAspectCircleGradient;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radiusScaleFactor = 2 * (constraints.maxWidth / Constraints.aspectVisualizationConstraints.maxWidth);

        final Sector aspectsSector = Sector(angle: angleForVisualisation, radius: constraints.maxWidth / 2);

        final List<AspectVisualizationInformation> aspectVisualizationInformation =
            AspectPositions(aspects: aspects, sector: aspectsSector).listOfAspectVisualizationInformation;

        final List<Widget> aspectCircles = aspectVisualizationInformation.map(
          (visualizationInformaion) {
            final size = (visualizationInformaion.weight.value + 0.9) * 10 * radiusScaleFactor;
            final gradient = visualizationInformaion.active ? activeAspectCircleGradient : inactiveAspectCircleGradient;

            return Positioned(
              left: visualizationInformaion.coordinate.x - (size / 2) + constraints.maxWidth / 2,
              top: visualizationInformaion.coordinate.y - (size / 2) + constraints.maxWidth / 2,
              width: size,
              height: size,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => logger.i('tap on aspect'),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
                    child: const SizedBox.shrink(),
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
