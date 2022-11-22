import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/services/api.dart';
import 'package:tabnews/src/widgets/layout.dart';

class PostPage extends StatefulWidget {
  final String username;
  final String slug;

  const PostPage({
    super.key,
    required this.username,
    required this.slug,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Content content = Content.fromJson({});
  final api = Api();
  final ScrollController _controller = ScrollController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _getContent();
  }

  Future<void> _getContent() async {
    var contentResp =
        await api.fetchContent('${widget.username}/${widget.slug}');

    setState(() {
      content = contentResp;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());

    return LayoutApp(
      pullToRefresh: _getContent,
      isLoading: isLoading,
      body: isLoading
          ? const SizedBox()
          : SingleChildScrollView(
              controller: _controller,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${content.ownerUsername} · ${timeago.format(DateTime.parse(content.publishedAt!), locale: "pt-BR")}',
                    style: const TextStyle().copyWith(
                      color: context.isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '${content.title}',
                    style: const TextStyle().copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Markdown(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 0.0,
                    ),
                    shrinkWrap: true,
                    controller: _controller,
                    data: '${content.body}',
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
                  ),
                ],
              ),
            ),
    );
  }
}
