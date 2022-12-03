import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tabnews/src/enviroment_vars.dart';

import 'package:tabnews/src/services/http_response.dart';

class AuthService {
  String get apiUrl => '${EnviromentVars.getVars.webserver}/api/v1';

  Future<HttpResponse> postLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/sessions'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return HttpResponse(response.statusCode, response.body);
  }

  Future<HttpResponse> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user'),
      headers: {
        'Set-Cookie': 'session_id=$token',
        'Cookie': 'session_id=$token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return HttpResponse(response.statusCode, response.body);
  }

  Future<HttpResponse> updateUser({
    required String token,
    required String? username,
    required String newUsername,
    required String newEmail,
    required bool? newNotifications,
  }) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/users/$username'),
      headers: {
        'Set-Cookie': 'session_id=$token',
        'Cookie': 'session_id=$token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        newUsername.isNotEmpty ? 'username' : newUsername: null,
        newEmail.isNotEmpty ? 'email' : newEmail: null,
        'notifications': newNotifications,
      }),
    );

    return HttpResponse(response.statusCode, response.body);
  }

  Future<HttpResponse> postRegister(
    String username,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    return HttpResponse(response.statusCode, response.body);
  }
}
