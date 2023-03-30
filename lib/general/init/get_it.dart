import 'package:get_it/get_it.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_cache.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_loader.dart';
import 'package:pd_app/general/services/input_output_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

final getIt = GetIt.instance;
const strapiCMSContentReadOnlyAPIToken =
    '9c3ed23622fe18bf8031ca2792d2917b5e0cd823e645107400599b0beaf7486d2c02466328778e7903130fb4040c590984921a30eecc2f9a641ed00b997e6f4b04ecea6ddc835dc27276e7dfe8162a1bc3970b0da9037797b2ab5195b76cc24e88903edb6975102c7a4e8636ffcd811c204294f6fb44818bd42886176fb591cd ';

void initGetIt() {
  getIt.registerSingleton(PatientDirectiveService());
  getIt.registerSingleton(InputOutputService());

  getIt.registerSingleton(CMSLoader(cmsConfig: CmsConfiguration.cmsConfig, apiToken: strapiCMSContentReadOnlyAPIToken));
  getIt.registerSingleton(CMSCache(definitions: CmsConfiguration.definitions));
}
