import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/models/comment.dart';
import 'package:tabnews/src/services/content.dart';
import 'package:tabnews/src/ui/widgets/item_comment.dart';

class CommentsWidget extends StatefulWidget {
  final List<Comment> comments;
  final ScrollController controller;
  final void Function() onAnswer;

  const CommentsWidget({
    super.key,
    required this.comments,
    required this.controller,
    required this.onAnswer,
  });

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  final api = ContentService();

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());

    return ListView.separated(
      shrinkWrap: true,
      controller: widget.controller,
      itemCount: widget.comments.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => ItemComment(
        comment: widget.comments[index],
        controller: widget.controller,
        onAnswer: widget.onAnswer,
      ),
    );
  }
}
