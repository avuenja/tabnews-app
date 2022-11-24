import 'package:flutter/material.dart';

import 'package:tabnews/src/app.dart';
import 'package:tabnews/src/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(const App());
}
