import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/services/content.dart';
import 'package:tabnews/src/ui/pages/profile_user.dart';
import 'package:tabnews/src/ui/widgets/answer.dart';
import 'package:tabnews/src/ui/widgets/comments_children.dart';
import 'package:tabnews/src/ui/widgets/tabcoins.dart';
import 'package:tabnews/src/utils/navigation.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/comment.dart';
import 'package:tabnews/src/ui/widgets/markdown.dart';

class ItemComment extends StatefulWidget {
  final Comment comment;
  final ScrollController controller;
  final void Function() onAnswer;

  const ItemComment({
    super.key,
    required this.comment,
    required this.controller,
    required this.onAnswer,
  });

  @override
  State<ItemComment> createState() => _ItemCommentState();
}

class _ItemCommentState extends State<ItemComment> {
  Comment get comment => widget.comment;
  ScrollController get controller => widget.controller;

  final _contentService = ContentService();

  _tabcoins(String vote) async {
    var tabcoinsResp = await _contentService.postTabcoins(
      '${comment.ownerUsername}/${comment.slug}',
      vote == 'upvote' ? 'credit' : 'debit',
    );

    if (tabcoinsResp.ok) {
      setState(() {
        comment.tabcoins = tabcoinsResp.data['tabcoins'];
      });
    } else {
      _onResponse(tabcoinsResp.message);
    }
  }

  void _onResponse(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());

    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigation.push(
                  context,
                  ProfileUserPage(username: '${comment.ownerUsername}'),
                ),
                child: Text('${comment.ownerUsername}'),
              ),
              Text(
                ' · ${timeago.format(DateTime.parse(comment.publishedAt!), locale: "pt-BR")}',
                style: const TextStyle().copyWith(
                  color: context.isDarkMode
                      ? Colors.grey.shade400
                      : Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: AppController.isLoggedIn,
                builder: (context, isLoggedIn, _) {
                  if (!isLoggedIn) {
                    return const SizedBox();
                  }

                  return Tabcoins(
                    upvote: () => _tabcoins('upvote'),
                    tabcoins: '${comment.tabcoins}',
                    downvote: () => _tabcoins('downvote'),
                  );
                },
              ),
            ],
          ),
          MarkedownReader(
            body: comment.body!,
            controller: controller,
          ),
          ValueListenableBuilder(
            valueListenable: AppController.isLoggedIn,
            builder: (context, isLoggedIn, child) {
              if (isLoggedIn) {
                return Column(
                  children: [
                    const SizedBox(height: 15.0),
                    Answer(
                      parentId: comment.id!,
                      inComment: true,
                      onAnswer: widget.onAnswer,
                    ),
                    const SizedBox(height: 15.0),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          comment.children!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: CommentsWidget(
                    comments: comment.children!,
                    controller: controller,
                    onAnswer: widget.onAnswer,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
