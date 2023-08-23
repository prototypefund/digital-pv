import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/dpv_button.dart';
import 'package:pd_app/general/view_components/dpv_card_with_checkbox_below.dart';

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

Widget buildRowWithExpandedText(BuildContext context, String question, String answer,
    {md.MarkdownStyleSheet? questionStyle, md.MarkdownStyleSheet? answerStyle, Color color = DefaultThemeColors.cyan}) {
  return IntrinsicHeight(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 600,
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
    {required String markdown, required String assetPath, bool showCheckboxBelow = true, required String more}) {
  return DPVCardWithCheckboxBelow(
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
            MarkdownBody(
              content: markdown,
              textAlignment: WrapAlignment.center,
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
      height: 400,
      width: 270);
}
