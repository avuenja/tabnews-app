import 'package:flutter/material.dart';

import 'package:tabnews/src/extensions/dark_mode.dart';

class AppSeparator extends StatelessWidget {
  const AppSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
      height: 3.0,
      margin: const EdgeInsets.all(15.0),
    );
  }
}
