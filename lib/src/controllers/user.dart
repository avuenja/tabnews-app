import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/models/user.dart';
import 'package:tabnews/src/preferences.dart';
import 'package:tabnews/src/services/auth.dart';
import 'package:tabnews/src/services/http_response.dart';

class UserController {
  final ViewAction _view;
  final AuthService _authService = AuthService();

  final String _userKey = AppConstants.userKey;

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  final ValueNotifier<bool> _notifications = ValueNotifier(
    AppController.user.value.notifications ?? true,
  );
  ValueNotifier<bool> get notification => _notifications;

  UserController(this._view);

  void setNotifications(bool? value) {
    _notifications.value = value ?? true;
  }

  void update(String username, String email) async {
    if (username.isEmpty || email.isEmpty) {
      _view.onError(message: 'É necessário preencher todos os campos!');

      return;
    }

    _setLoading(true);
    final HttpResponse user = await _authService.updateUser(
      token: AppController.auth.value,
      username: AppController.user.value.username,
      newUsername:
          AppController.user.value.username != username ? username : '',
      newEmail: AppController.user.value.email != email ? email : '',
      newNotifications: _notifications.value,
    );

    if (user.ok) {
      var user = await _authService.fetchUser(AppController.auth.value);

      Preferences.setString(_userKey, jsonEncode(user.data));

      _setUser(User.fromJson(user.data));

      _view.onSuccess();
    } else {
      _view.onError(message: user.message);
    }

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading.value = value;
  }

  void _setUser(User value) {
    AppController.user.value = value;
  }
}
