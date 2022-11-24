import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tabnews/src/login_state.dart';
import 'package:tabnews/src/ui/layouts/tab.dart';

class App extends StatelessWidget {
  final LoginState loginState;

  const App({super.key, required this.loginState});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => loginState,
        ),
      ],
      child: MaterialApp(
        title: 'TabNews',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: const TabLayout(),
      ),
    );
  }
}
