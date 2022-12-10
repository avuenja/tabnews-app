import 'package:flutter/material.dart';
import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/controllers/content.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/ui/widgets/answer.dart';
import 'package:tabnews/src/ui/widgets/source_url.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/controllers/favorites.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/content.dart';
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

class _ContentPageState extends State<ContentPage> implements ViewAction {
  final FavoritesController _favoritesController = FavoritesController();
  late ContentController _contentController;

  Content content = Content.fromJson({});
  final ScrollController _controller = ScrollController();
  bool isLoading = true;

  String get slug => '${widget.username}/${widget.slug}';

  @override
  void initState() {
    super.initState();

    _contentController = ContentController(this);
    _getContent();
  }

  @override
  onError({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  onSuccess({data}) {
    setState(() {
      content = Content.fromJson(data);
      isLoading = false;
    });
  }

  _getContent() {
    _contentController.getContent(slug);
  }

  String _getTitleParent(Content parent) {
    if (content.parentId != null) {
      String body = parent.body!;
      String title = body.replaceRange(50, body.length, '...');

      return 'Respondendo a "$title"';
    } else {
      return 'Em resposta a "${parent.title}"';
    }
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());

    return PageLayout(
      onRefresh: () => _getContent(),
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
                          content.parent != null
                              ? _getTitleParent(content.parent!)
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
                            ? SourceUrl(sourceUrl: content.sourceUrl!)
                            : const SizedBox(),
                        ValueListenableBuilder(
                          valueListenable: AppController.isLoggedIn,
                          builder: (context, isLoggedIn, child) {
                            if (isLoggedIn) {
                              return Column(
                                children: [
                                  const SizedBox(height: 30.0),
                                  Answer(parentId: content.id!),
                                  const SizedBox(height: 30.0),
                                ],
                              );
                            } else {
                              return Column(
                                children: const [
                                  SizedBox(height: 30.0),
                                  Divider(),
                                  SizedBox(height: 30.0),
                                ],
                              );
                            }
                          },
                        ),
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
