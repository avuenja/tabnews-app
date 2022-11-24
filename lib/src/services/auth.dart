import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tabnews/src/models/auth.dart';
import 'package:tabnews/src/models/user.dart';

class ApiAuth {
  final apiUrl = 'https://www.tabnews.com.br/api/v1';

  Future<Auth> postLogin(String email, String password) async {
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

    if (response.statusCode == 201) {
      return Auth.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user'),
      headers: {
        'Set-Cookie': 'session_id=$token',
        'Cookie': 'session_id=$token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<User> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user'),
      headers: {
        'Set-Cookie': 'session_id=$token',
        'Cookie': 'session_id=$token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load singular content');
    }
  }
}
