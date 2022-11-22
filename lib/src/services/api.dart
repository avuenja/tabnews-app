import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tabnews/src/models/content.dart';

class Api {
  final apiUrl = 'https://www.tabnews.com.br/api/v1/contents';

  Future<List<Content>> fetchContents() async {
    final response = await http.get(Uri.parse(apiUrl));

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

  Future<List<Content>> fetchContentsNew() async {
    final response = await http.get(Uri.parse('$apiUrl?strategy=new'));

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
}
