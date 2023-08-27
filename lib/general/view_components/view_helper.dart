import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/themes/thresholds.dart';
import 'package:pd_app/general/view_components/dpv_button.dart';
import 'package:pd_app/general/view_components/dpv_card_with_checkbox_below.dart';
import 'package:pd_app/general/view_components/responsive_addon_content/responsive_addon_content.dart';

Widget buildCenterText(String text, BuildContext context, {Color textColor = DefaultThemeColors.black}) {
  return Center(
      child: MarkdownBody(
    // style: style,
    textAlignment: WrapAlignment.center,
    content: text,
    color: textColor,
  ));
}

Widget buildText(String text, BuildContext context, {Color textColor = DefaultThemeColors.black}) {
  return MarkdownBody(
    content: text,
    color: textColor,
  );
}

md.MarkdownStyleSheet get answerStyle => md.MarkdownStyleSheet(
      p: const TextStyle(color: DefaultThemeColors.black),
    );

const double maximumContentWidth = 1200;
const double responsiveAddonThreshold = Thresholds.responsiveAddonContent;
const double contentAreaPadding = 32.0;

Widget wrapper(BuildContext context, CreationProcessNavigationViewModel viewModel, Widget widget) {
  return Scaffold(
    bottomNavigationBar: const Card(
        margin: EdgeInsets.zero,
        child: Padding(
            padding: Paddings.bottomNavigationBarPadding,
            child: NavigationBarButtons<CreationProcessNavigationViewModel>())),
    body: ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        children: [
          CustomScrollView(
            controller: viewModel.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: ConstrainedSliverWidth(
                  maxWidth: maximumContentWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(contentAreaPadding),
                    // will just make empty space for the stack to be drawn upon further up the widget tree
                    child: viewModel.showFloatingAspectVisualizationIfSpaceAvailable
                        ? ResponsiveAddonContent(
                            extendedContent: const SizedBox.shrink(),
                            widthThreshold: responsiveAddonThreshold,
                            child: widget,
                          )
                        : widget,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildRowWithExpandedText(BuildContext context, String question, String answer,
    {md.MarkdownStyleSheet? questionStyle,
    md.MarkdownStyleSheet? answerStyle,
    Color color = DefaultThemeColors.cyan,
    double width = 600}) {
  return IntrinsicHeight(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width,
          child: MarkdownBody(
            content: question,
            color: color,
          ),
        ),
        const SizedBox(width: 30),
        const VerticalDivider(width: 20, thickness: 0.5, color: Colors.grey),
        const SizedBox(width: 30),
        Expanded(
            child: MarkdownBody(
          content: answer,
        )),
      ],
    ),
  );
}

Widget card(
    {required String markdown,
    required String assetPath,
    bool showCheckboxBelow = true,
    required String more,
    md.MarkdownStyleSheet? styleSheet,
    EdgeInsets? edgeInsets,
    Function(bool?)? onChanged,
    bool? checked}) {
  return DPVCardWithCheckboxBelow(
      onChanged: onChanged,
      value: false,
      edgeInsets: EdgeInsets.zero,
      showCheckboxBelow: showCheckboxBelow,
      showCheckbox: false,
      title: '',
      // assetPath: "assets/images/create.svg",
      titleChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: edgeInsets ?? EdgeInsets.zero,
              child: MarkdownBody(
                styleSheet: styleSheet,
                content: markdown,
                textAlignment: WrapAlignment.center,
              ),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(
              assetPath,
              colorFilter: ColorFilter.mode(DefaultThemeColors.mediumGrey, BlendMode.srcIn),
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 40),
            DPVButton(
              onPressed: () {},
              title: more,
            )
          ]),
      padding: EdgeInsets.zero,
      height: 440,
      width: 270);
}
