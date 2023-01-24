import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pd_app/general/services/input_output_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingletonAsync(() => PackageInfo.fromPlatform());
  getIt.registerSingleton(PatientDirectiveService());
  getIt.registerSingleton(InputOutputService());
}
