import 'package:flutter/material.dart';

import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/services/content.dart';
import 'package:tabnews/src/services/http_response.dart';

class CommentController {
  final ViewAction _view;
  final ContentService _contentService = ContentService();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  CommentController(this._view);

  void create(String body, String parentId) async {
    if (body.isEmpty) {
      _view.onError(message: 'É necessário preencher o campo obrigatório!');

      return;
    }

    _setLoading(true);
    final HttpResponse content = await _contentService.postComment(
      AppController.auth.value,
      parentId,
      body,
    );

    if (content.ok) {
      _view.onSuccess();
    } else {
      _view.onError(message: content.message);
    }

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading.value = value;
  }
}
