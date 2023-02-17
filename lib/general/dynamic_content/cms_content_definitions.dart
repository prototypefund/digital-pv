import 'package:pd_app/general/dynamic_content/aspects_example.dart';
import 'package:pd_app/general/dynamic_content/components/content_definition.dart';

import 'positive_aspects_page.dart';

mixin CmsContentDefinitions {
  static List<ContentDefinition> definitions = [
    ContentDefinition<AspectsExample>(
        isSingleEntity: false,
        cmsEntityName: 'aspect-examples',
        fieldsToPopulate: ['example', 'example.contextual_help'],
        buildObjectFunction: (baseMap, attributesMap) => AspectsExample.fromCMSJson(baseMap, attributesMap),
        localEntityName: 'positive-aspects-examples',
        queryParameters: {'filters[show_as_positive_aspect_example][\$eq]': 'true'}),
    ContentDefinition<AspectsExample>(
        isSingleEntity: false,
        cmsEntityName: 'aspect-examples',
        fieldsToPopulate: ['example', 'example.contextual_help'],
        buildObjectFunction: (baseMap, attributesMap) => AspectsExample.fromCMSJson(baseMap, attributesMap),
        localEntityName: 'negative-aspects-examples',
        queryParameters: {'filters[show_as_negative_aspect_example][\$eq]': 'true'}),
    ContentDefinition<AspectsExample>(
        isSingleEntity: false,
        cmsEntityName: 'aspect-examples',
        fieldsToPopulate: ['example', 'example.contextual_help'],
        buildObjectFunction: (baseMap, attributesMap) => AspectsExample.fromCMSJson(baseMap, attributesMap),
        localEntityName: 'future-situations-examples',
        queryParameters: {'filters[show_as_future_situation_example][\$eq]': 'true'}),
    ContentDefinition<PositiveAspectsPage>(
        isSingleEntity: true,
        cmsEntityName: 'positive-aspects-page',
        fieldsToPopulate: [],
        buildObjectFunction: (baseMap, attributesMap) => PositiveAspectsPage.fromCMSJson(attributesMap),
        localEntityName: 'positive-aspects-page',
        queryParameters: {}),
  ];
}
