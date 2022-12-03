import 'package:flutter/material.dart';

import 'package:tabnews/src/app.dart';
import 'package:tabnews/src/enviroment_vars.dart';
import 'package:tabnews/src/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  await EnviromentVars.init(useProdEnv: true);

  runApp(const App());
}
