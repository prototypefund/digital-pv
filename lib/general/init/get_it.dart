import 'package:get_it/get_it.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_cache.dart';
import 'package:pd_app/general/services/input_output_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton(PatientDirectiveService());
  getIt.registerSingleton(InputOutputService());
  getIt.registerSingleton(CMSCache(definitions: CmsConfiguration.definitions));
}
