import 'package:flutter/widgets.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/view_components/directive_visualization/aspect_circle_painter.dart';
import 'package:pd_app/general/view_components/directive_visualization/aspect_positions.dart';
import 'package:pd_app/general/view_components/directive_visualization/sector.dart';

class AspectsVisualization extends StatelessWidget {
  const AspectsVisualization({
    required this.aspects,
    required this.angleForVisualisation,
    required this.aspectCircleGradient,
  });

  final List<Aspect> aspects;
  final double angleForVisualisation;
  final Gradient aspectCircleGradient;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radiusScaleFactor = constraints.maxWidth / Constraints.aspectVisualizationConstraints.maxWidth;

        final Sector aspectsSector = Sector(angle: angleForVisualisation, radius: constraints.maxWidth / 2);

        final List<AspectVisualizationInformation> aspectVisualizationInformation =
            AspectPositions(aspects: aspects, sector: aspectsSector).listOfAspectVisualizationInformation;

        final List<CustomPaint> aspectCircles = aspectVisualizationInformation
            .map(
              (visualizationInformaion) => CustomPaint(
                painter: AspectCirclePainter(
                  coordinate: visualizationInformaion.coordinate,
                  // TODO: remove hardcoded factors and explain how to use them
                  radius: (visualizationInformaion.weight.value + 0.9) * 13 * radiusScaleFactor,
                  gradient: aspectCircleGradient,
                ),
              ),
            )
            .toList();

        return Stack(
          alignment: AlignmentDirectional.center,
          children: aspectCircles,
        );
      },
    );
  }
}
