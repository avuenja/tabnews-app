import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tabnews/src/app.dart';
import 'package:tabnews/src/login_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final state = LoginState(await SharedPreferences.getInstance());
  state.checkLoggedIn();

  runApp(App(loginState: state));
}
