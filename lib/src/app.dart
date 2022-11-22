import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabnews/src/login_state.dart';

import 'package:tabnews/src/routes.dart';

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
        Provider<Routes>(
          lazy: false,
          create: (context) => Routes(loginState),
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = Provider.of<Routes>(context, listen: false).router;

          return MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            title: 'TabNews',
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              primaryColor: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
