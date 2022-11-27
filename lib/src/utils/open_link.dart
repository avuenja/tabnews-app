import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tabnews/src/ui/pages/content.dart';
import 'package:tabnews/src/utils/navigation.dart';

abstract class OpenLink {
  static void open(String? href, BuildContext context) {
    if (href != null) {
      Uri uri = Uri.parse(href);

      if (_isTabNews(uri) && uri.pathSegments.length > 1) {
        _launchInApp(uri, context);
      } else {
        _launchExternal(uri);
      }
    }
  }

  static bool _isTabNews(Uri uri) {
    return uri.host == 'www.tabnews.com.br';
  }

  static void _launchExternal(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static void _launchInApp(Uri uri, BuildContext context) {
    List<String> segments = uri.pathSegments;

    String username = segments[0];
    String slug = segments[1];

    Navigation.push(context, ContentPage(username: username, slug: slug));
  }
}
