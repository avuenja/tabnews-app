import 'package:flutter/material.dart';

import 'package:tabnews/src/providers/user.dart';
import 'package:tabnews/src/services/api.dart';

class ContentProvider extends ChangeNotifier {
  static final ContentProvider _instance = ContentProvider._internal();

  final api = Api();

  factory ContentProvider() {
    return _instance;
  }

  ContentProvider._internal() {
    _isLoading = false;
    _isCreated = false;
  }

  late bool _isLoading;
  bool get isLoading => _isLoading;

  late bool _isCreated;
  bool get isCreated => _isCreated;

  void _loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void create(String title, String body, String source) async {
    _loading(true);

    var content = await api.postContent(
      UserProvider().sessionId,
      title,
      body,
      source,
    );

    if (content.id!.isNotEmpty) {
      _isCreated = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
