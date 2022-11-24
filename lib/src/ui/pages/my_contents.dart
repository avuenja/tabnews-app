import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/providers/user.dart';
import 'package:tabnews/src/services/api.dart';
import 'package:tabnews/src/ui/layouts/page.dart';
import 'package:tabnews/src/ui/widgets/item_content.dart';
import 'package:tabnews/src/ui/widgets/progress_indicator.dart';

class MyContentsPage extends StatefulWidget {
  const MyContentsPage({super.key});

  @override
  State<MyContentsPage> createState() => _MyContentsPageState();
}

class _MyContentsPageState extends State<MyContentsPage> {
  late List<Content> contents;
  final api = Api();
  bool isLoading = true;
  static const _perPage = 30;

  final PagingController<int, Content> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _getContents(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _getContents(int page) async {
    final content = await api.fetchMyContents(
      page: page,
      user: '${UserProvider().user?.username}',
    );

    final isLastPage = content.length < _perPage;

    if (isLastPage) {
      _pagingController.appendLastPage(content);
    } else {
      final nextPage = page + 1;

      _pagingController.appendPage(content, nextPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      body: PagedListView<int, Content>(
        padding: const EdgeInsets.all(10.0),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Content>(
          itemBuilder: (context, item, index) {
            return ItemContent(
              index: index,
              content: item,
            );
          },
          firstPageProgressIndicatorBuilder: (_) =>
              const AppProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const AppProgressIndicator(),
        ),
      ),
    );
  }
}
