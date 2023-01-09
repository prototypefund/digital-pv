import 'package:pd_app/general/model/patient_directive.dart';

///
/// chooses from the given patient directive a list of aspects to read and manipulate
typedef AspectListChoice<AspectType> = List<AspectType> Function(PatientDirective patientDirective);
