import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tabnews/src/constants.dart';

class AppTopBar extends StatelessWidget with PreferredSizeWidget {
  final List<Widget>? actions;

  const AppTopBar({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      backgroundColor: AppColors.primaryColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
