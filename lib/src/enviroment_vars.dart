import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviromentVars {
  static late EnviromentVars _singleton;
  static EnviromentVars get getVars => _singleton;

  late final String _webserver;
  String get webserver => _webserver;

  late final bool _debugEnv;
  bool get debugEnv => _debugEnv;

  static Future init({bool useProdEnv = false}) async {
    bool devEnviroment = kDebugMode && !useProdEnv;
    dotenv = DotEnv();

    if (devEnviroment) {
      await dotenv.load(fileName: ".env.dev");
    } else {
      await dotenv.load(fileName: ".env.prod");
    }

    _singleton = EnviromentVars();
    _singleton._webserver =
        dotenv.get("WEBSERVER_HOST", fallback: "www.tabnews.com.br");
    _singleton._debugEnv = devEnviroment;
  }
}
