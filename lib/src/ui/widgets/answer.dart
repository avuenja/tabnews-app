import 'package:flutter/material.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'package:tabnews/src/controllers/comment.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/ui/widgets/markdown.dart';

class Answer extends StatefulWidget {
  final bool inComment;
  final String parentId;
  final void Function() onAnswer;

  const Answer({
    super.key,
    this.inComment = false,
    required this.parentId,
    required this.onAnswer,
  });

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> implements ViewAction {
  late CommentController _commentController;

  bool isAnswering = false;
  bool isViewMarkdown = false;

  TextEditingController bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _commentController = CommentController(this);
  }

  @override
  onSuccess({data}) {
    bodyTextController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Comentário publicado com sucesso!',
        ),
      ),
    );

    setState(() {
      isAnswering = false;
    });

    widget.onAnswer();
  }

  @override
  onError({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    bodyTextController.dispose();

    super.dispose();
  }

  void cancel() {
    bodyTextController.clear();

    setState(() {
      isAnswering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inComment) {
      return _buildAnswer();
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: _buildAnswer(),
    );
  }

  Widget _buildAnswer() {
    return isAnswering
        ? Column(
            children: [
              isViewMarkdown
                  ? SizedBox(
                      height: 420.0,
                      child: MarkedownReader(body: bodyTextController.text),
                    )
                  : MarkdownTextInput(
                      maxLines: 20,
                      label: 'Comentário',
                      controller: bodyTextController,
                      actions: MarkdownType.values,
                      (value) {},
                      bodyTextController.text,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isViewMarkdown = !isViewMarkdown;
                      });
                    },
                    child: Text(isViewMarkdown ? 'Escrever' : 'Visualizar'),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: cancel,
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 5.0),
                  ElevatedButton(
                    onPressed: () => _commentController.create(
                      bodyTextController.text,
                      widget.parentId,
                    ),
                    child: const Text('Publicar'),
                  ),
                ],
              ),
            ],
          )
        : Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAnswering = true;
                  });
                },
                child: const Text('Responder'),
              ),
            ],
          );
  }
}
