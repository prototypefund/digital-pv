import 'package:flutter/material.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/dpv_card_with_checkbox_below.dart';
import 'package:pd_app/general/view_components/dpv_checkbox_card.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class TreatmentActivitiesSelection<ViewModelType extends TreatmentActivitiesSelectionViewModel> extends StatelessWidget
    with RootContextL10N, Logging {
  @override
  Widget build(BuildContext context) {
    logger.t('rebuilding TreatmentActivitiesSelection');
    final ViewModelType viewModel = context.watch();
    return Column(
      children: [
        Column(
          children: viewModel.treatmentActivities
              .asMap()
              .map((index, e) => MapEntry(
                  index, _buildTreatmentActivityChoice(context, e, index, viewModel.treatmentActivities.length)))
              .values
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTreatmentActivityChoice(BuildContext context, TreatmentActivity activity, int index, int length) {
    final ViewModelType viewModel = context.watch();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DPVWrappedBoxCheckbox(
            crossAxisAlignment: CrossAxisAlignment.start,
            borderRadius: BorderRadius.circular(35),
            showCheckbox: false,
            title: '',
            padding: const EdgeInsets.all(14),
            edgeInsets: const EdgeInsets.all(14),
            titleChild: Stack(
              children: [
                Positioned(
                    top: 25,
                    right: 14,
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.info),
                      onPressed: () {},
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 35.0),
                  child: Column(children: [
                    Center(child: MarkdownBody(content: """
#### Maßnahme ${index + 1}/$length
### ${activity.activity}
                """)),
                    Wrap(spacing: 14, runSpacing: 14, children: [
                      ...activity.choices.map((value) => value.choice).toList().map((choice) {
                        final state = CheckboxState();
                        state.setChecked(viewModel.getCurrentChoice(activity) == choice);
                        return Row(children: [
                          ChangeNotifierProvider<CheckboxState>(
                            key: UniqueKey(),
                            create: (_) => state,
                            child: DPVCheckboxCard(
                              checkboxOnly: true,
                              onChanged: (value) {
                                logger.d('changing activity ${activity.activity} to value $value');
                                viewModel.updateChoice(activity, choice);
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(child: Text(choice, softWrap: true)),
                        ]);
                      }),
                    ]),
                    const SizedBox(height: 14),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
