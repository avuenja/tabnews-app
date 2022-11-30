import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/controllers/favorites.dart';
import 'package:tabnews/src/utils/open_link.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/services/content.dart';
import 'package:tabnews/src/ui/widgets/markdown.dart';
import 'package:tabnews/src/ui/widgets/comments.dart';
import 'package:tabnews/src/ui/layouts/page.dart';
import 'package:tabnews/src/ui/widgets/progress_indicator.dart';

class ContentPage extends StatefulWidget {
  final String username;
  final String slug;

  const ContentPage({
    super.key,
    required this.username,
    required this.slug,
  });

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final FavoritesController _favoritesController = FavoritesController();

  Content content = Content.fromJson({});
  final _contentService = ContentService();
  final ScrollController _controller = ScrollController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _getContent();
  }

  Future<void> _getContent() async {
    var contentResp = await _contentService.fetchContent(
      '${widget.username}/${widget.slug}',
    );

    setState(() {
      content = contentResp;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());

    return PageLayout(
      onRefresh: _getContent,
      actions: isLoading
          ? null
          : [
              IconButton(
                onPressed: () => _favoritesController.toggle(
                  content,
                ),
                icon: ValueListenableBuilder(
                  valueListenable: _favoritesController.favorites,
                  builder: (context, favorites, child) {
                    bool isFavorited = favorites
                        .where((element) => element.id == content.id)
                        .isNotEmpty;

                    return Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                    );
                  },
                ),
              ),
            ],
      body: isLoading
          ? const AppProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          content.parentId != null
                              ? 'Em resposta a...'
                              : '${content.title}',
                          style: const TextStyle().copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        MarkedownReader(
                          body: '${content.body}',
                          controller: _controller,
                        ),
                        content.sourceUrl != null
                            ? Row(
                                children: [
                                  Text(
                                    'Fonte: ',
                                    style: const TextStyle().copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => OpenLink.open(
                                      content.sourceUrl,
                                      context,
                                    ),
                                    child: Text(
                                      '${content.sourceUrl}',
                                      style: const TextStyle().copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 30.0),
                        const Divider(),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    child: CommentsRootWidget(
                      slug: '${widget.username}/${widget.slug}',
                      controller: _controller,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
