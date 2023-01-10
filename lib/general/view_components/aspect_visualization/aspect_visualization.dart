import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/widgets.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class AspectVisualization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AspectVisualizationViewModel _viewModel = context.watch();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Stack(
            children: [
              Image.asset(_viewModel.evaluationImageBackground),
              Positioned.fill(
                child: Transform.rotate(
                  angle: _viewModel.arrowRotation,
                  child: CustomPaint(
                    painter: ArrowPainter(color: DefaultThemeColors.purple), // TODO change to theme extension
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter with Logging {
  ArrowPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;

    Path path = Path();
    path.moveTo(size.width * 0.12, size.height / 2);
    path.relativeLineTo(size.width * 0.76, 0);
    path = ArrowPath.make(path: path);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
