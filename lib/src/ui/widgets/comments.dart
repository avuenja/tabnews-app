import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/models/comment.dart';
import 'package:tabnews/src/services/api.dart';
import 'package:tabnews/src/ui/widgets/item_comment.dart';

class CommentsWidget extends StatefulWidget {
  final String slug;
  final ScrollController controller;

  const CommentsWidget({
    super.key,
    required this.slug,
    required this.controller,
  });

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  List<Comment> comments = [];
  final api = Api();

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

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());

    return ListView.separated(
      shrinkWrap: true,
      controller: widget.controller,
      itemCount: comments.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => ItemComment(
        comment: comments[index],
        controller: widget.controller,
      ),
    );
  }
}
