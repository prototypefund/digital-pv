import 'package:pd_app/general/model/aspect.dart';

class PatientDirective {
  PatientDirective({required this.positiveAspects, required this.futureSituationAspects});

  final List<Aspect> positiveAspects;
  final List<Aspect> futureSituationAspects;
}
