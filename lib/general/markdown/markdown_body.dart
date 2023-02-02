import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as markdown;

/// simple wrapper around markdown body, so we can easily replace it with our own package
class MarkdownBody extends StatelessWidget {
  const MarkdownBody({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return markdown.MarkdownBody(
      data: content,
      fitContent: false,
      styleSheet: markdown.MarkdownStyleSheet(),
    );
  }
}
