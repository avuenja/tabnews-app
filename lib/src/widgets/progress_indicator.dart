import 'package:flutter/material.dart';

import 'package:tabnews/src/extensions/dark_mode.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
