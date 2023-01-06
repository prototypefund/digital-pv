import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';

///
/// chooses from the given patient directive a list of aspects to read and manipulate
typedef AspectListChoice = List<Aspect> Function(PatientDirective patientDirective);
