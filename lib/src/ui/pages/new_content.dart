import 'package:flutter/material.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/controllers/content.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/ui/layouts/page.dart';
import 'package:tabnews/src/ui/pages/my_contents.dart';
import 'package:tabnews/src/ui/widgets/markdown.dart';
import 'package:tabnews/src/utils/navigation.dart';

class NewContentPage extends StatefulWidget {
  const NewContentPage({super.key});

  @override
  State<NewContentPage> createState() => _NewContentPageState();
}

class _NewContentPageState extends State<NewContentPage> implements ViewAction {
  late final ContentController _contentController;

  TextEditingController titleTextController = TextEditingController();
  TextEditingController bodyTextController = TextEditingController();
  TextEditingController sourceTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isViewMarkdown = false;

  @override
  void initState() {
    super.initState();

    _contentController = ContentController(this);
  }

  @override
  onSuccess({data}) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Conteúdo publicado com sucesso!',
        ),
      ),
    );

    Navigation.pop(context);
    Navigation.push(context, const MyContentsPage());
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
    titleTextController.dispose();
    bodyTextController.dispose();
    sourceTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      onRefresh: () async {},
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  cursorColor: context.isDarkMode
                      ? Colors.white
                      : AppColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.isDarkMode
                            ? Colors.white
                            : AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Título',
                  ),
                  controller: titleTextController,
                ),
                const SizedBox(height: 15.0),
                isViewMarkdown
                    ? SizedBox(
                        height: 420.0,
                        child: MarkedownReader(body: bodyTextController.text),
                      )
                    : MarkdownTextInput(
                        maxLines: 20,
                        label: 'Conteúdo',
                        controller: bodyTextController,
                        actions: MarkdownType.values,
                        (value) {},
                        bodyTextController.text,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isViewMarkdown = !isViewMarkdown;
                        });
                      },
                      child: Text(isViewMarkdown ? 'Escrever' : 'Visualizar'),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  cursorColor: context.isDarkMode
                      ? Colors.white
                      : AppColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.isDarkMode
                            ? Colors.white
                            : AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Fonte (opcional)',
                  ),
                  controller: sourceTextController,
                ),
                const SizedBox(height: 30.0),
                ValueListenableBuilder(
                  valueListenable: _contentController.isLoading,
                  builder: (context, isLoading, child) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor.withOpacity(
                            isLoading ? 0.5 : 1.0,
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () => _contentController.create(
                                titleTextController.text,
                                bodyTextController.text,
                                sourceTextController.text,
                              ),
                      child: Text(
                        isLoading ? 'Aguarde...' : 'Publicar',
                        style: const TextStyle().copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
