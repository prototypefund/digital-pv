import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as markdown;
import 'package:pd_app/general/themes/colors.dart';

/// simple wrapper around markdown body, so we can easily replace it with our own package
class MarkdownBody extends StatelessWidget {
  const MarkdownBody(
      {super.key,
      required this.content,
      this.styleSheet,
      this.textAlignment = WrapAlignment.start,
      this.color = DefaultThemeColors.black});

  final Color color;

  final String content;

  final WrapAlignment textAlignment;

  final markdown.MarkdownStyleSheet? styleSheet;

  @override
  Widget build(BuildContext context) {
    return markdown.MarkdownBody(
      data: content,
      fitContent: false,
      styleSheet: styleSheet ??
          markdown.MarkdownStyleSheet(
              h1: TextStyle(color: color),
              h2: TextStyle(color: color),
              h3: TextStyle(color: color),
              h4: TextStyle(color: color),
              p: TextStyle(color: color),
              textAlign: textAlignment,
              h1Align: textAlignment,
              h2Align: textAlignment,
              h3Align: textAlignment,
              h4Align: textAlignment,
              h5Align: textAlignment,
              h6Align: textAlignment),
    );
  }
}
