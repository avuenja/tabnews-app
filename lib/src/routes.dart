import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/login_state.dart';
import 'package:tabnews/src/pages/error.dart';
import 'package:tabnews/src/pages/home.dart';

import 'package:tabnews/src/pages/login.dart';
import 'package:tabnews/src/pages/post.dart';

class Routes {
  final LoginState loginState;

  Routes(this.loginState);

  late final router = GoRouter(
    refreshListenable: loginState,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (context, state) => state.namedLocation(homeRouteName),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: createAccountRouteName,
        path: '/register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: homeRouteName,
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        name: postRouteName,
        path: '/post/:username/:slug',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: PostPage(
            username: state.params['username']!,
            slug: state.params['slug']!,
          ),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
    redirect: (context, state) {
      final loginLoc = state.namedLocation(loginRouteName);
      final loggingIn = state.subloc == loginLoc;

      final createAccountLoc = state.namedLocation(createAccountRouteName);
      final creatingAccount = state.subloc == createAccountLoc;

      final loggedIn = loginState.loggedIn;
      final rootLoc = state.namedLocation(rootRouteName);

      if (!loggedIn && !loggingIn && !creatingAccount) return loginLoc;
      if (loggedIn && (loggingIn || creatingAccount)) return rootLoc;
      return null;
    },
  );
}
