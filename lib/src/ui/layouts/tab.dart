import 'package:flutter/material.dart';

import 'package:tabnews/src/controllers/app.dart';
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

class _TabLayoutState extends State<TabLayout> with WidgetsBindingObserver {
  List<ScrollController> pagesScrollController = [
    ScrollController(),
    ScrollController(),
  ];

  int _currentPage = 0;
  late final List<Widget> _pages = [
    HomePage(scrollController: pagesScrollController[0]),
    RecentsPage(scrollController: pagesScrollController[1]),
    const FavoritesPage(),
    ValueListenableBuilder(
      valueListenable: AppController.isLoggedIn,
      builder: (context, isLoggedIn, child) {
        return isLoggedIn ? const ProfilePage() : const LoginPage();
      },
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index != _currentPage) {
        _currentPage = index;
      } else {
        pagesScrollController[_currentPage].animateTo(
          0,
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppController.isLoggedIn.value && state == AppLifecycleState.resumed) {
      AppController.updateUser();
    }
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
