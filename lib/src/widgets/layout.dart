import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tabnews/src/extensions/dark_mode.dart';

class LayoutApp extends StatelessWidget {
  final Future<void> Function() pullToRefresh;
  final Widget body;
  final bool isLoading;

  const LayoutApp({
    super.key,
    required this.body,
    required this.pullToRefresh,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            SvgPicture.asset(
              'lib/assets/logo.svg',
              semanticsLabel: 'TabNews',
            ),
            const SizedBox(width: 10.0),
            const Text('TabNews'),
          ],
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(36, 41, 47, 1),
      ),
      body: RefreshIndicator(
        color: context.isDarkMode ? Colors.white : Colors.black,
        onRefresh: pullToRefresh,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              )
            : body,
      ),
    );
  }
}
