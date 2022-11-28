import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static final FavoritesProvider _instance = FavoritesProvider._internal();

  factory FavoritesProvider() {
    return _instance;
  }

  FavoritesProvider._internal() {
    _isLoading = false;
    _isCreated = false;
    _favorites = [];

    _getSavedFavorites();
  }

  late bool _isLoading;
  bool get isLoading => _isLoading;

  late bool _isCreated;
  bool get isCreated => _isCreated;

  late List<Content> _favorites;
  List<Content> get favorites => _favorites;

  void _loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _getSavedFavorites() async {
    String savedFavorties = Preferences.getString('favorites') ?? '';

    if (savedFavorties.isNotEmpty) {
      List contents = jsonDecode(savedFavorties);
      for (var favorite in contents) {
        _favorites.add(Content.fromJson(favorite));
      }
      notifyListeners();
    }
  }

  bool isFavorited(String id) {
    bool isFavorite =
        _favorites.where((element) => element.id == id).isNotEmpty;

    if (isFavorite) {
      return true;
    }

    return false;
  }

  void toggle(Content content) async {
    _loading(true);
    Content copyContent = content;

    if (_favorites.isNotEmpty) {
      if (_favorites.where((element) => element.id == content.id).isNotEmpty) {
        _favorites.removeWhere((element) => element.id == content.id);
      } else {
        copyContent.body = null;
        _favorites.add(copyContent);
      }
    } else {
      copyContent.body = null;
      _favorites.add(copyContent);
    }

    Preferences.setString('favorites', jsonEncode(_favorites));

    _isLoading = false;
    notifyListeners();
  }
}
