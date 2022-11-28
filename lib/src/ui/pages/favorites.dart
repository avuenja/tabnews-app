import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/providers/favorites.dart';
import 'package:tabnews/src/ui/widgets/item_content.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(builder: (context, provider, _) {
      if (provider.favorites.isEmpty) {
        return const Center(
          child: Text('Você não possui favoritos!'),
        );
      } else {
        List<Content> favorites = provider.favorites;

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
    });
  }
}
