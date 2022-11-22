import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/comment.dart';
import 'package:tabnews/src/widgets/markdown.dart';

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
          Text(
            '${comment.ownerUsername} · ${timeago.format(DateTime.parse(comment.publishedAt!), locale: "pt-BR")}',
            style: const TextStyle().copyWith(
              color: context.isDarkMode
                  ? Colors.grey.shade400
                  : Colors.grey.shade700,
            ),
          ),
          MarkedownReader(
            body: comment.body!,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
