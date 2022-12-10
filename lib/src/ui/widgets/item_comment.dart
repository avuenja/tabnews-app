import 'package:flutter/material.dart';
import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/ui/pages/profile_user.dart';
import 'package:tabnews/src/ui/widgets/answer.dart';
import 'package:tabnews/src/ui/widgets/comments_children.dart';
import 'package:tabnews/src/utils/navigation.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/comment.dart';
import 'package:tabnews/src/ui/widgets/markdown.dart';

class ItemComment extends StatelessWidget {
  final Comment comment;
  final ScrollController controller;

  const ItemComment({
    super.key,
    required this.comment,
    required this.controller,
  });

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
            ],
          ),
          MarkedownReader(
            body: comment.body!,
            controller: controller,
          ),
          comment.children!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: CommentsWidget(
                    comments: comment.children!,
                    controller: controller,
                  ),
                )
              : const SizedBox(),
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
                    ),
                    const SizedBox(height: 15.0),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
