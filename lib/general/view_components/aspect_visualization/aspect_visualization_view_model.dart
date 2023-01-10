import "dart:math" as math;

import 'package:flutter/cupertino.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';

class AspectVisualizationViewModel with ChangeNotifier, Logging {
  AspectVisualizationViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
  }

  final PatientDirectiveService _patientDirectiveService;

  String get evaluationImageBackground => 'assets/images/placeholder.png';

  /// arrow rotation in radians
  /// by default the arrow is pointing to the right (very negative)
  /// rotating by PI means pointing to the left (very positive)
  ///
  double get arrowRotation {
    final aspectScore = _patientDirectiveService.currentPatientDirective.currentAspectsScore;
    // -1 = very negative should become 0
    // +1 = very positive should become PI
    // 0 = equal should become PI / 2
    final rotation = math.pi / 2 * aspectScore + math.pi / 2;
    logger.d('aspect score is $aspectScore, resulting in rotation of $rotation rads');
    return rotation;
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }
}
