import 'package:flutter/material.dart';

class Tabcoins extends StatefulWidget {
  final String tabcoins;
  final void Function() upvote;
  final void Function() downvote;

  const Tabcoins({
    super.key,
    required this.tabcoins,
    required this.upvote,
    required this.downvote,
  });

  @override
  State<Tabcoins> createState() => _TabcoinsState();
}

class _TabcoinsState extends State<Tabcoins> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: widget.upvote,
          icon: const Icon(Icons.expand_less),
        ),
        Text(widget.tabcoins),
        IconButton(
          onPressed: widget.downvote,
          icon: const Icon(Icons.expand_more),
        ),
      ],
    );
  }
}
