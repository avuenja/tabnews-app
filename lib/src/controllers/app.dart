import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/models/user.dart';
import 'package:tabnews/src/preferences.dart';

class AppController {
  static final AppController _singleton = AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal();

  static const String _loggedKey = AppConstants.loggedInKey;
  static const String _authKey = AppConstants.authKey;
  static const String _userKey = AppConstants.userKey;

  static ValueNotifier<bool> isLoggedIn = ValueNotifier(
    Preferences.getBool(AppController._loggedKey) ?? false,
  );
  static ValueNotifier<String> auth = ValueNotifier(
    Preferences.getString(AppController._authKey) ?? '',
  );
  static ValueNotifier<User> user = ValueNotifier(
    AppController._getLoggedUser(),
  );

  static User _getLoggedUser() {
    String pref = Preferences.getString(_userKey) ?? '';

    if (pref.isNotEmpty) {
      User user = User.fromJson(jsonDecode(pref));

      return user;
    }

    return User.fromJson({});
  }
}
