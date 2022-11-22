import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabnews/src/login_state.dart';

import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/services/api.dart';
import 'package:tabnews/src/widgets/item_card.dart';
import 'package:tabnews/src/widgets/layout.dart';
import 'package:tabnews/src/widgets/progress_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Content> contents;
  final api = Api();
  bool isLoading = true;
  static const _perPage = 30;

  final PagingController<int, Content> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    test();

    _pagingController.addPageRequestListener((pageKey) {
      _getContents(pageKey);
    });
  }

  test() async {
    print(LoginState(await SharedPreferences.getInstance()).session.id);
  }

  @override
  void dispose() {
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _getContents(int page) async {
    final content = await api.fetchContents(page: page);

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
    return LayoutApp(
      pullToRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      body: PagedListView<int, Content>(
        padding: const EdgeInsets.all(10.0),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Content>(
          itemBuilder: (context, item, index) {
            return ItemCard(index: index, content: item);
          },
          firstPageProgressIndicatorBuilder: (_) =>
              const AppProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) => const AppProgressIndicator(),
        ),
      ),
      isLoading: false,
    );
  }
}
