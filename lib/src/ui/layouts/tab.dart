import 'package:flutter/material.dart';

import 'package:tabnews/src/ui/pages/favorites.dart';
import 'package:tabnews/src/ui/pages/home.dart';
import 'package:tabnews/src/ui/pages/profile.dart';
import 'package:tabnews/src/ui/pages/recents.dart';
import 'package:tabnews/src/ui/widgets/bottom_bar.dart';
import 'package:tabnews/src/ui/widgets/top_bar.dart';

class TabLayout extends StatefulWidget {
  const TabLayout({super.key});

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  int _currentPage = 0;
  static const List<Widget> _pages = [
    HomePage(),
    RecentsPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const AppTopBar(),
      body: IndexedStack(
        index: _currentPage,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomBar(
        onTap: _onItemTapped,
        currentPage: _currentPage,
      ),
    );
  }
}
