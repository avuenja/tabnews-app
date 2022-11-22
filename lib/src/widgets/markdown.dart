import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class MarkedownReader extends StatelessWidget {
  final String body;
  final ScrollController controller;

  const MarkedownReader({
    super.key,
    required this.body,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Markdown(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 0.0,
      ),
      shrinkWrap: true,
      controller: controller,
      data: body,
      selectable: true,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        [
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
          md.LineBreakSyntax(),
          md.LinkSyntax(),
          md.EmojiSyntax(),
          md.InlineHtmlSyntax(),
          md.ImageSyntax(),
          md.AutolinkExtensionSyntax(),
        ],
      ),
    );
  }
}
