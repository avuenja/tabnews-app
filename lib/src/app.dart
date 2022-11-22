import 'package:flutter/material.dart';

import 'package:tabnews/src/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TabNews',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      routerConfig: Routes.router,
    );
  }
}
