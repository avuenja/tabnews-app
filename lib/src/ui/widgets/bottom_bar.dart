import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tabnews/src/constants.dart';

class AppBottomBar extends StatelessWidget {
  final int currentPage;
  final void Function(int) onTap;

  const AppBottomBar({
    super.key,
    required this.onTap,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: BottomNavigationBar(
          currentIndex: currentPage,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.primaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Recentes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
