import 'dart:io';

import 'package:flutter_gen/gen_l10n/l10n_de.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_cache.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_loader.dart';
import 'package:pd_app/general/main_app/patient_directive_app.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

import 'mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final L10nDe l10n = L10nDe();
  late ContentService contentService;
  late MockCMSLoader mockCMSLoader;
  setUp(() async {
    HttpOverrides.global = null; // disable http clients for image fetching in markdown
    await GetIt.instance.reset();

    mockCMSLoader = MockCMSLoader();
    when(mockCMSLoader.loadEntitiesFromCMS(
            locale: anyNamed('locale'), contentDefinition: anyNamed('contentDefinition')))
        .thenThrow('test execution');

    GetIt.instance.registerSingleton(PatientDirectiveService());
    GetIt.instance.registerSingleton(l10n);
    GetIt.instance.registerSingleton<CMSLoader>(mockCMSLoader);
    GetIt.instance.registerSingleton(CMSCache(definitions: CmsConfiguration.definitions));
    contentService = ContentService(locale: l10n.localeName, loadOnlineContent: false);
    await contentService.reloadContent();
    GetIt.instance.registerSingleton(contentService);
  });

  testWidgets('can load PD app without exception', (WidgetTester tester) async {
    await tester.pumpWidget(const PatientDirectiveApp());
  }, skip: true);
}
