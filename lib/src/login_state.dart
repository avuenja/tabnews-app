import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabnews/src/models/auth.dart';

import 'constants.dart';

class LoginState extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _loggedIn = false;
  Auth _session = Auth.fromJson({});

  LoginState(this.prefs) {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
    session = Auth.fromJson(
      jsonDecode(prefs.getString('${loggedInKey}_auth') ?? '{}'),
    );
  }

  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    prefs.setBool(loggedInKey, value);
    notifyListeners();
  }

  Auth get session => _session;
  set session(Auth auth) {
    prefs.setString('${loggedInKey}_auth', jsonEncode(auth.toJson()));
    notifyListeners();
  }

  void checkLoggedIn() {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
    session = Auth.fromJson(
      jsonDecode(prefs.getString('${loggedInKey}_auth') ?? '{}'),
    );
  }
}
