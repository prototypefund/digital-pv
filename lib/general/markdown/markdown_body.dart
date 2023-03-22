import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as markdown;

/// simple wrapper around markdown body, so we can easily replace it with our own package
class MarkdownBody extends StatelessWidget {
  const MarkdownBody({super.key, required this.content, this.textAlignment = WrapAlignment.start});

  final String content;

  final WrapAlignment textAlignment;

  @override
  Widget build(BuildContext context) {
    return markdown.MarkdownBody(
      data: content,
      fitContent: false,
      styleSheet: markdown.MarkdownStyleSheet(
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
