import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tabnews/src/providers/user.dart';
import 'package:tabnews/src/ui/layouts/tab.dart';
import 'package:tabnews/src/ui/pages/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'TabNews',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: Consumer<UserProvider>(
          builder: (context, user, _) =>
              user.loggedIn ? const TabLayout() : const LoginPage(),
        ),
      ),
    );
  }
}
