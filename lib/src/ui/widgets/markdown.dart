import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import 'package:tabnews/src/utils/open_link.dart';

class MarkedownReader extends StatelessWidget {
  final String body;
  final ScrollController? controller;

  const MarkedownReader({
    super.key,
    required this.body,
    this.controller,
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
      onTapLink: (text, href, title) {
        OpenLink.open(href, context);
      },
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubWeb.blockSyntaxes,
        [
          ...md.ExtensionSet.gitHubWeb.inlineSyntaxes,
        ],
      ),
    );
  }
}
