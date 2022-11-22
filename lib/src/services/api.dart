import 'package:dio/dio.dart';

import 'package:tabnews/src/models/content.dart';

class Api {
  final apiUrl = 'https://www.tabnews.com.br/api/v1/contents';

  Future<List<Content>> fetchContents() async {
    try {
      final response = await Dio().get(apiUrl);

      var dataJson = response.data;
      List<Content> contents = [];

      dataJson.forEach((item) {
        contents.add(Content.fromJson(item));
      });

      return contents;
    } catch (e) {
      throw Exception('Failed to load contents');
    }
  }

  Future<List<Content>> fetchContentsNew() async {
    try {
      final response = await Dio().get('$apiUrl?strategy=new');

      var dataJson = response.data;
      List<Content> contents = [];

      dataJson.forEach((item) {
        contents.add(Content.fromJson(item));
      });

      return contents;
    } catch (e) {
      throw Exception('Failed to load new contents');
    }
  }

  Future<Content> fetchContent(String slug) async {
    try {
      final response = await Dio().get('$apiUrl/$slug');

      return Content.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load content');
    }
  }
}
