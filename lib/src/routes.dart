import 'package:go_router/go_router.dart';

import 'package:tabnews/src/pages/home.dart';
import 'package:tabnews/src/pages/post.dart';

abstract class Routes {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'post/:username/:slug',
            builder: (context, state) => PostPage(
              username: state.params['username']!,
              slug: state.params['slug']!,
            ),
          ),
        ],
      ),
    ],
  );
}
