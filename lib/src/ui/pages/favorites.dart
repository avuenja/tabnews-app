import 'package:flutter/material.dart';

import 'package:tabnews/src/controllers/favorites.dart';
import 'package:tabnews/src/ui/widgets/item_content.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoritesController _favoritesController = FavoritesController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _favoritesController.favorites,
      builder: (context, favorites, child) {
        if (favorites.isEmpty) {
          return const Center(
            child: Text('Você não possui favoritos!'),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return ItemContent(
                content: favorites[index],
              );
            },
          );
        }
      },
    );
  }
}
