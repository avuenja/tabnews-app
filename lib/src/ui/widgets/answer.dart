import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final bool inComment;

  const Answer({super.key, this.inComment = false});

  @override
  Widget build(BuildContext context) {
    if (inComment) {
      return Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Responder'),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Responder'),
          ),
        ],
      ),
    );
  }
}
