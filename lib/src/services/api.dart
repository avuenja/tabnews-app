import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tabnews/src/models/comment.dart';

import 'package:tabnews/src/models/content.dart';

class Api {
  final apiUrl = 'https://www.tabnews.com.br/api/v1/contents';

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

  Future<Content> fetchContent(String slug) async {
    final response = await http.get(Uri.parse('$apiUrl/$slug'));

    if (response.statusCode == 200) {
      return Content.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load singular content');
    }
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
}
