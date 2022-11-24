import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static bool? getBool(String key) => _instance.getBool(key);
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  static String? getString(String key) => _instance.getString(key);
  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);
}
