import 'package:flutter/foundation.dart';
import 'package:pd_app/general/dynamic_content/aspects_example.dart';
import 'package:pd_app/general/dynamic_content/cms_cache.dart';
import 'package:pd_app/general/dynamic_content/positive_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/logging.dart';

class ContentService with Logging {
  ContentService({required this.locale}) : _cmsCache = getIt.get() {
    reloadContent();
  }

  final CMSCache _cmsCache;
  final String locale;

  List<AspectsExample> _positiveAspectsExamples = [];
  List<AspectsExample> _negativeAspectsExamples = [];
  List<AspectsExample> _futureSituationsExamples = [];
  PositiveAspectsPage _positiveAspectsPage = PositiveAspectsPage(intro: null, outro: null, locale: "");

  List<AspectsExample> get positiveAspectsExamples {
    return _positiveAspectsExamples;
  }

  List<AspectsExample> get negativeAspectsExamples {
    return _negativeAspectsExamples;
  }

  List<AspectsExample> get futureSituationsExamples {
    return _futureSituationsExamples;
  }

  PositiveAspectsPage get positiveAspectsPage => _positiveAspectsPage;

  Future<void> _loadPositiveAspectExamples() async {
    logger.d('loading positive aspects with locale $locale');
    _positiveAspectsExamples = await _cmsCache.loadEntitiesFromAssetCache(
        locale: locale,
        entityName: 'positive-aspects-examples',
        loadingFunction: (json) => AspectsExample.fromJson(json));
    logger.d('loading positive aspects with locale $locale DONE');
  }

  Future<void> _loadNegativeAspectExamples() async {
    logger.d('loading negative aspects with locale $locale');
    _negativeAspectsExamples = await _cmsCache.loadEntitiesFromAssetCache(
        locale: locale,
        entityName: 'negative-aspects-examples',
        loadingFunction: (json) => AspectsExample.fromJson(json));
    logger.d('loading negative aspects with locale $locale DONE');
  }

  Future<void> _loadFutureSituationExamples() async {
    logger.d('loading future situation examples with locale $locale');
    _futureSituationsExamples = await _cmsCache.loadEntitiesFromAssetCache(
        locale: locale,
        entityName: 'future-situations-examples',
        loadingFunction: (json) => AspectsExample.fromJson(json));
    logger.d('loading future situation examples with locale $locale DONE');
  }

  Future<void> _loadPositiveAspectsPage() async {
    logger.d('loading positive aspects page with locale $locale');
    _positiveAspectsPage = (await _cmsCache.loadEntitiesFromAssetCache(
            locale: locale,
            entityName: 'positive-aspects-page',
            loadingFunction: (json) => PositiveAspectsPage.fromJson(json)))
        .first;
    logger.d('loading positive aspects page with $locale DONE');
  }

  @visibleForTesting
  Future<void> reloadContent() async {
    await _loadPositiveAspectExamples();
    await _loadNegativeAspectExamples();
    await _loadFutureSituationExamples();
    await _loadPositiveAspectsPage();
  }
}
