import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/models/user.dart';
import 'package:tabnews/src/services/content.dart';
import 'package:tabnews/src/services/user.dart';
import 'package:tabnews/src/ui/layouts/page.dart';
import 'package:tabnews/src/ui/widgets/item_content.dart';
import 'package:tabnews/src/ui/widgets/progress_indicator.dart';

class ProfileUserPage extends StatefulWidget {
  final String username;

  const ProfileUserPage({super.key, required this.username});

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  final userService = UserService();
  final _contentService = ContentService();
  bool _isLoading = true;
  late User _user;

  static const _perPage = 30;
  final PagingController<int, Content> _pagingController =
      PagingController(firstPageKey: 1);

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _getUser();
    _pagingController.addPageRequestListener((pageKey) {
      _getContents(pageKey);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pagingController.dispose();

    super.dispose();
  }

  Future<void> _getContents(int page) async {
    final content = await _contentService.fetchMyContents(
      page: page,
      user: widget.username,
    );

    final isLastPage = content.length < _perPage;

    if (isLastPage) {
      _pagingController.appendLastPage(content);
    } else {
      final nextPage = page + 1;

      _pagingController.appendPage(content, nextPage);
    }
  }

  _getUser() async {
    var userRet = await userService.fetchUser(widget.username);

    setState(() {
      _user = userRet;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      onRefresh: () async {},
      body: _isLoading
          ? const AppProgressIndicator()
          : SingleChildScrollView(
              controller: _controller,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    '${_user.username}',
                    style: const TextStyle().copyWith(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const Divider(),
                  const SizedBox(height: 15.0),
                  PagedListView<int, Content>(
                    shrinkWrap: true,
                    scrollController: _controller,
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Content>(
                      itemBuilder: (context, item, index) {
                        return ItemContent(content: item);
                      },
                      firstPageProgressIndicatorBuilder: (_) =>
                          const AppProgressIndicator(),
                      newPageProgressIndicatorBuilder: (_) =>
                          const AppProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
