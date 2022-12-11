import 'package:flutter/material.dart';

import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/services/content.dart';
import 'package:tabnews/src/services/http_response.dart';

class ContentController {
  final ViewAction _view;
  final ContentService _contentService = ContentService();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  ContentController(this._view);

  void create(String title, String body, String source) async {
    if (title.isEmpty || body.isEmpty) {
      _view.onError(message: 'É necessário preencher os campos obrigatórios!');

      return;
    }

    _setLoading(true);
    final HttpResponse content = await _contentService.postContent(
      AppController.auth.value,
      title,
      body,
      source,
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

  void getContent(String slug) async {
    _setLoading(true);
    var contentResp = await _contentService.fetchContent(slug);

    if (contentResp.ok) {
      if (contentResp.data['parent_id'] != null) {
        contentResp.data['parent'] = await _getParentContent(slug);
      }

      _view.onSuccess(data: contentResp.data);
    } else {
      _view.onError(message: contentResp.message);
    }

    _setLoading(false);
  }

  Future<Content?> _getParentContent(String slug) async {
    var parentContent = await _contentService.fetchContentParent(slug);

    if (parentContent.ok) {
      return Content.fromJson(parentContent.data);
    } else {
      return null;
    }
  }
}
