import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:pd_app/use_cases/upsert_patient_directive_page_4/upsert_patient_directive_page_4_view_model.dart';
import 'package:provider/provider.dart';

class UpsertPatientDirectivePage4View extends StatelessWidget {
  const UpsertPatientDirectivePage4View({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => UpsertPatientDirectivePage4ViewModel(), child: const UpsertPatientDirectivePage4View());
  }

  void showMoreInfo(BuildContext context, String text, String dismiss, String moreInfo) {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: DefaultThemeColors.white,
                      height: 4.0,
                    ),
                  ),
                  const SizedBox(width: 20, height: 40),
                  MarkdownBody(
                    data: moreInfo,
                    styleSheet: MarkdownStyleSheet(
                      h2: const TextStyle(color: DefaultThemeColors.white),
                    ),
                  ),
                  const SizedBox(width: 20, height: 40),
                  const Expanded(
                    child: Divider(
                      color: DefaultThemeColors.white,
                      height: 4.0,
                    ),
                  ),
                  const Spacer(),
                  Positioned(
                    right: 0,
                    top: -10,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: DefaultThemeColors.white,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(44.0),
                  child: TextButton(
                    child: Text(dismiss, style: const TextStyle(color: DefaultThemeColors.white)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
              backgroundColor: DefaultThemeColors.cyan,
              content: Builder(
                builder: (context) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 580,
                    ),
                    child: Stack(
                      children: [
                        MarkdownBody(
                          data: text,
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(color: DefaultThemeColors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final UpsertPatientDirectivePage4ViewModel viewModel = context.watch();

    return CreationProcessNavigation<UpsertPatientDirectivePage4ViewModel>(
      widget: Column(
        children: [
          buildCenterText(viewModel.subtitle, context, Theme.of(context).textTheme.headlineSmall!),
          const SizedBox(height: 80),
          buildRowWithExpandedText(viewModel.importantPointsQuestion, viewModel.importantPointsAnswer),
          const SizedBox(height: 60),
          buildCenterText(viewModel.title, context, Theme.of(context).textTheme.headlineMedium!),
          const SizedBox(height: 60),
          buildRowWithCheckboxAndMarkdown(
              viewModel.cardOneText, viewModel.cardOneDescription, viewModel, context, viewModel.cardOneIsSelected,
              (value) {
            viewModel.deactivateAll();
            viewModel.cardOneIsSelected = true;
          }, onTapLink: (text, href, title) {
            showMoreInfo(context, viewModel.cardOneMore, viewModel.dismiss, viewModel.moreInfo);
          }),
          const SizedBox(height: 40),
          buildRowWithCheckboxAndMarkdown(
              viewModel.cardTwoText, viewModel.cardTwoDescription, viewModel, context, viewModel.cardTwoIsSelected,
              (value) {
            viewModel.deactivateAll();
            viewModel.cardTwoIsSelected = true;
          }, onTapLink: (text, href, title) {
            showMoreInfo(context, viewModel.cardTwoMore, viewModel.dismiss, viewModel.moreInfo);
          }),
          const SizedBox(height: 40),
          buildRowWithCheckboxAndMarkdown(viewModel.cardThreeText, viewModel.cardThreeDescription, viewModel, context,
              viewModel.cardThreeIsSelected, (value) {
            viewModel.deactivateAll();
            viewModel.cardThreeIsSelected = true;
          }, onTapLink: (text, href, title) {
            showMoreInfo(context, viewModel.cardThreeMore, viewModel.dismiss, viewModel.moreInfo);
          }),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildCenterText(String text, BuildContext context, TextStyle style) {
    return Center(child: Text(text, textAlign: TextAlign.center, style: style));
  }

  Widget buildRowWithExpandedText(String question, String answer) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 400, child: MarkdownBody(data: question)),
          const SizedBox(width: 30),
          const VerticalDivider(width: 20, thickness: 0.5, color: Colors.grey),
          Expanded(
            child: MarkdownBody(
              data: answer,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRowWithCheckboxAndMarkdown(String checkboxText, String markdownText,
      UpsertPatientDirectivePage4ViewModel viewModel, BuildContext context, bool value, Function(bool?) onChanged,
      {MarkdownTapLinkCallback? onTapLink}) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 180,
            ),
            child: DPVWrappedBoxCheckbox(
              rightAlignCheckbox: true,
              showCheckbox: true,
              edgeInsets: const EdgeInsets.only(top: 15, bottom: 15),
              // height: 180,
              width: 400,
              title: '',
              titleChild: MarkdownBody(data: checkboxText),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: value,
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 30),
          const VerticalDivider(width: 20, thickness: 0.5, indent: 20, endIndent: 20, color: Colors.grey),
          Expanded(
            child: MarkdownBody(data: markdownText, onTapLink: onTapLink),
          ),
        ],
      ),
    );
  }
}
