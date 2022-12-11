import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/enviroment_vars.dart';
import 'package:tabnews/src/models/comment.dart';

import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/services/http_response.dart';

class ContentService {
  String get apiUrl => "${EnviromentVars.getVars.webserver}/api/v1/contents";

  Future<List<Content>> fetchContents({int page = 1}) async {
    final response = await http.get(Uri.parse('$apiUrl?page=$page'));

    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      List<Content> contents = [];

      dataJson.forEach((item) {
        contents.add(Content.fromJson(item));
      });

      return contents;
    } else {
      throw Exception('Failed to load contents');
    }
  }

  Future<List<Content>> fetchContentsNew({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$apiUrl?strategy=new&page=$page'),
    );

    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      List<Content> contents = [];

      dataJson.forEach((item) {
        contents.add(Content.fromJson(item));
      });

      return contents;
    } else {
      throw Exception('Failed to load new contents');
    }
  }

  Future<HttpResponse> fetchContent(String slug) async {
    final response = await http.get(Uri.parse('$apiUrl/$slug'));

    return HttpResponse(response.statusCode, response.body);
  }

  Future<HttpResponse> fetchContentParent(String slug) async {
    final response = await http.get(Uri.parse('$apiUrl/$slug/parent'));

    return HttpResponse(response.statusCode, response.body);
  }

  Future<List<Comment>> fetchContentComments(String slug) async {
    final response = await http.get(Uri.parse('$apiUrl/$slug/children'));

    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      List<Comment> comments = [];

      dataJson.forEach((item) {
        comments.add(Comment.fromJson(item));
      });

      return comments;
    } else {
      throw Exception('Failed to load singular content children');
    }
  }

  Future<List<Content>> fetchMyContents({
    int page = 1,
    required String user,
  }) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$user?strategy=new&page=$page'),
    );

    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      List<Content> contents = [];

      dataJson.forEach((item) {
        contents.add(Content.fromJson(item));
      });

      return contents;
    } else {
      throw Exception('Failed to load my contents');
    }
  }

  Future<HttpResponse> postContent(
    String token,
    String title,
    String body,
    String source,
  ) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Set-Cookie': 'session_id=$token',
        'Cookie': 'session_id=$token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
        'status': 'published',
        source.isNotEmpty ? 'source_url' : source: null,
      }),
    );

    return HttpResponse(response.statusCode, response.body);
  }

  Future<HttpResponse> postComment(
    String token,
    String parentId,
    String body,
  ) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Set-Cookie': 'session_id=$token',
        'Cookie': 'session_id=$token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'parent_id': parentId,
        'body': body,
        'status': 'published',
      }),
    );

    return HttpResponse(response.statusCode, response.body);
  }

  Future<HttpResponse> postTabcoins(String slug, String type) async {
    final response = await http.post(
      Uri.parse('$apiUrl/$slug/tabcoins'),
      headers: {
        'Set-Cookie': 'session_id=${AppController.auth.value}',
        'Cookie': 'session_id=${AppController.auth.value}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'transaction_type': type,
      }),
    );

    AppController.updateUser();

    return HttpResponse(response.statusCode, response.body);
  }
}
