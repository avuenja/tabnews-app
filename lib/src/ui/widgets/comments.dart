import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/models/comment.dart';
import 'package:tabnews/src/services/content.dart';
import 'package:tabnews/src/ui/widgets/item_comment.dart';

class CommentsRootWidget extends StatefulWidget {
  final String slug;
  final ScrollController controller;

  const CommentsRootWidget({
    super.key,
    required this.slug,
    required this.controller,
  });

  @override
  State<CommentsRootWidget> createState() => _CommentsRootWidgetState();
}

class _CommentsRootWidgetState extends State<CommentsRootWidget> {
  List<Comment> comments = [];
  final api = ContentService();

  Key _refreshKey = UniqueKey();

  @override
  void initState() {
    super.initState();

    _getComments();
  }

  Future<void> _getComments() async {
    var comment = await api.fetchContentComments(widget.slug);

    setState(() {
      comments = comment;
    });
  }

  void _onAnswer() {
    setState(() {
      _refreshKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());

    return ListView.separated(
      controller: widget.controller,
      itemCount: comments.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => ItemComment(
        key: _refreshKey,
        comment: comments[index],
        controller: widget.controller,
        onAnswer: _onAnswer,
      ),
    );
  }
}
