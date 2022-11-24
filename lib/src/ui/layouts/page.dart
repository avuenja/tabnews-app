import 'package:flutter/material.dart';

import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/ui/widgets/progress_indicator.dart';
import 'package:tabnews/src/ui/widgets/top_bar.dart';

class PageLayout extends StatelessWidget {
  final Widget body;
  final bool isLoading;

  const PageLayout({
    super.key,
    required this.body,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: RefreshIndicator(
        color: context.isDarkMode ? Colors.white : Colors.black,
        onRefresh: () async {},
        child: isLoading ? const AppProgressIndicator() : body,
      ),
    );
  }
}
