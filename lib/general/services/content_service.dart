import 'package:flutter/foundation.dart';
import 'package:pd_app/general/dynamic_content/aspects_example.dart';
import 'package:pd_app/general/dynamic_content/cms_cache.dart';
import 'package:pd_app/general/dynamic_content/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/components/add_aspect_widget.dart';
import 'package:pd_app/general/dynamic_content/components/aspect_list_widget.dart';
import 'package:pd_app/general/dynamic_content/onboarding.dart';
import 'package:pd_app/general/dynamic_content/positive_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/logging.dart';

class ContentService with Logging, ChangeNotifier {
  ContentService({required this.locale}) : _cmsCache = getIt.get() {
    reloadContent();
  }

  final CMSCache _cmsCache;
  final String locale;

  List<AspectsExample> get positiveAspectsExamples {
    return _cmsCache
        .value<AspectsExample>(contentDefinition: CmsConfiguration.positiveAspectExamples, defaultValue: []);
  }

  List<AspectsExample> get negativeAspectsExamples {
    return _cmsCache
        .value<AspectsExample>(contentDefinition: CmsConfiguration.negativeAspectExamples, defaultValue: []);
  }

  List<AspectsExample> get futureSituationsExamples {
    return _cmsCache
        .value<AspectsExample>(contentDefinition: CmsConfiguration.futureSituationExamples, defaultValue: []);
  }

  PositiveAspectsPage get positiveAspectsPage =>
      _cmsCache.value<PositiveAspectsPage>(contentDefinition: CmsConfiguration.positiveAspectPage, defaultValue: [
        PositiveAspectsPage(
            intro: null,
            outro: null,
            locale: locale,
            examplesTitle: '',
            aspectListWidget: AspectListWidget(
                deleteConfirmationQuestion: '',
                lowSignificanceLabel: '',
                highSignificanceLabel: '',
                emptyListMessage: ''),
            addAspectWidget: AddAspectWidget(
                emptyTextFieldHint: '', lowSignificanceLabel: '', highSignificanceLabel: '', addAspectActionLabel: ''))
      ]).first;

  Onboarding get onboarding => _cmsCache.value<Onboarding>(
      contentDefinition: CmsConfiguration.onboarding,
      defaultValue: [Onboarding(skipLabel: '', pages: [], nextButtonLabel: '', callToActionLabel: '')]).first;

  @visibleForTesting
  Future<void> reloadContent() async {
    await _cmsCache.reloadAll(locale: locale);
    notifyListeners();
  }
}
