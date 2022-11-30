import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/models/user.dart';
import 'package:tabnews/src/preferences.dart';
import 'package:tabnews/src/services/auth.dart';
import 'package:tabnews/src/services/http_response.dart';

class AuthController {
  final ViewAction _view;
  final AuthService _authService = AuthService();

  final String _loggedKey = AppConstants.loggedInKey;
  final String _authKey = AppConstants.authKey;
  final String _userKey = AppConstants.userKey;

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  final ValueNotifier<bool> _isRegister = ValueNotifier(false);
  ValueNotifier<bool> get isRegister => _isRegister;

  AuthController(this._view);

  void login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _view.onError(message: 'É necessário preencher todos os campos!');

      return;
    }

    _setLoading(true);
    final HttpResponse auth = await _authService.postLogin(email, password);

    if (auth.ok) {
      var user = await _authService.fetchUser(auth.data['token']);

      Preferences.setString(_authKey, auth.data['token']);
      Preferences.setString(_userKey, jsonEncode(user.data));
      Preferences.setBool(_loggedKey, true);

      _setLoggedIn(true);
      _setToken(auth.data['token']);
      _setUser(User.fromJson(user.data));

      _view.onSuccess();
    } else {
      _view.onError(message: auth.message);
    }

    _setLoading(false);
  }

  void logout() {
    Preferences.setString(_authKey, '');
    Preferences.setString(_userKey, '');
    Preferences.setBool(_loggedKey, false);
    _setLoggedIn(false);
    _setToken('');
    _setUser(User());
  }

  void register(String username, String email, String password) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _view.onError(message: 'É necessário preencher todos os campos!');

      return;
    }

    _setLoading(true);
    final HttpResponse register = await _authService.postRegister(
      username,
      email,
      password,
    );

    if (register.ok) {
      _setRegister(true);

      _view.onSuccess();
    } else {
      _view.onError(message: register.message);
    }

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading.value = value;
  }

  void _setRegister(bool value) {
    _isRegister.value = value;
  }

  void _setLoggedIn(bool value) {
    AppController.isLoggedIn.value = value;
  }

  void _setToken(String value) {
    AppController.auth.value = value;
  }

  void _setUser(User value) {
    AppController.user.value = value;
  }
}
