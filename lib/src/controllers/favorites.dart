import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/preferences.dart';

class FavoritesController {
  static final FavoritesController _singleton = FavoritesController._internal();

  factory FavoritesController() {
    return _singleton;
  }

  FavoritesController._internal();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  final ValueNotifier<List<Content>> _favorites = ValueNotifier(
    FavoritesController._getSavedFavorites(),
  );
  ValueNotifier<List<Content>> get favorites => _favorites;

  static List<Content> _getSavedFavorites() {
    String pref = Preferences.getString('favorites') ?? '';

    if (pref.isNotEmpty) {
      List<dynamic> contents = jsonDecode(pref);

      return contents.map<Content>((e) => Content.fromJson(e)).toList();
    }

    return [];
  }

  void toggle(Content content) async {
    _setLoading(true);
    Content copyContent = content;

    if (_favorites.value.isNotEmpty) {
      if (_favorites.value
          .where((element) => element.id == content.id)
          .isNotEmpty) {
        _favorites.value = List.from(_favorites.value)
          ..removeWhere((element) => element.id == content.id);
      } else {
        copyContent.body = null;
        _favorites.value = List.from(_favorites.value)..add(copyContent);
      }
    } else {
      copyContent.body = null;
      _favorites.value = List.from(_favorites.value)..add(copyContent);
    }

    Preferences.setString('favorites', jsonEncode(_favorites.value));

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading.value = value;
  }
}
