import 'package:get_it/get_it.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_cache.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_loader.dart';
import 'package:pd_app/general/services/input_output_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

final getIt = GetIt.instance;
const apiReadOnlyToken =
    '7d7bd3bbdd0268282c11510677efd471a255bb48c8b6f4d0149d55baca0524600927c303b093fda0e9e29454c049ffa25b5f21463e4ee33bd3e24db03e858e342d74014d225a1790a8595fa559adc218f8da44cfaa2bc2123988273d31f40179b0221d39893ba1a116e09ecce591dfa73d428aad55d9f218a38b66c83dcfb240';

void initGetIt() {
  getIt.registerSingleton(PatientDirectiveService());
  getIt.registerSingleton(InputOutputService());

  getIt.registerSingleton(CMSLoader(cmsConfig: CmsConfiguration.cmsConfig, apiToken: apiReadOnlyToken));
  getIt.registerSingleton(CMSCache(definitions: CmsConfiguration.definitions));
}
