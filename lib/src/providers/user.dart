import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/models/auth.dart';
import 'package:tabnews/src/models/user.dart';
import 'package:tabnews/src/preferences.dart';
import 'package:tabnews/src/services/auth.dart';

class UserProvider extends ChangeNotifier {
  static final UserProvider _instance = UserProvider._internal();

  final api = ApiAuth();
  final String _loggedKey = AppConstants.loggedInKey;
  final String _authKey = AppConstants.authKey;
  final String _userKey = AppConstants.userKey;

  factory UserProvider() {
    return _instance;
  }

  UserProvider._internal() {
    _loggedIn = Preferences.getBool(_loggedKey) ?? false;

    if (_loggedIn) {
      _sessionId = _getSessionId();
      _user = _getUser();
    }
  }

  late bool _loggedIn;
  bool get loggedIn => _loggedIn;

  late String _sessionId;
  String get sessionId => _sessionId;

  User? _user;
  User? get user => _user;

  void login(String email, String password) async {
    var auth = await api.postLogin(email, password);

    if (auth.id!.isNotEmpty) {
      var user = await api.fetchUser(auth.token!);

      Preferences.setString(_authKey, jsonEncode(auth.toJson()));
      Preferences.setString(_userKey, jsonEncode(user.toJson()));
      Preferences.setBool(_loggedKey, true);
      _loggedIn = true;
      _sessionId = auth.token!;
      _user = user;
    }

    notifyListeners();
  }

  void logout() {
    Preferences.setString(_authKey, '');
    Preferences.setString(_userKey, '');
    Preferences.setBool(_loggedKey, false);
    _loggedIn = false;
    _sessionId = '';
    _user = null;

    notifyListeners();
  }

  String _getSessionId() {
    String pref = Preferences.getString(_authKey) ?? '';

    if (pref.isNotEmpty) {
      Auth auth = Auth.fromJson(jsonDecode(pref));

      return auth.token!;
    }

    return '';
  }

  User _getUser() {
    String pref = Preferences.getString(_userKey) ?? '';

    if (pref.isNotEmpty) {
      User user = User.fromJson(jsonDecode(pref));

      return user;
    }

    return User.fromJson({});
  }
}
