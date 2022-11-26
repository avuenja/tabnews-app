import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabnews/src/providers/user.dart';

import 'package:tabnews/src/ui/pages/favorites.dart';
import 'package:tabnews/src/ui/pages/home.dart';
import 'package:tabnews/src/ui/pages/login.dart';
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
  static final List<Widget> _pages = [
    const HomePage(),
    const RecentsPage(),
    const FavoritesPage(),
    Consumer<UserProvider>(
      builder: (context, provider, _) =>
          provider.loggedIn ? const ProfilePage() : const LoginPage(),
    ),
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
