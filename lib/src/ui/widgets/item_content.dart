import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/ui/pages/content.dart';
import 'package:tabnews/src/ui/pages/profile_user.dart';
import 'package:tabnews/src/utils/navigation.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/content.dart';

class ItemContent extends StatelessWidget {
  final Content content;

  const ItemContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt-BR', timeago.PtBrMessages());
    var date = DateTime.parse(content.publishedAt!);
    bool isComment = false;

    if (content.parentId != null) {
      isComment = true;
    }

    return InkWell(
      onTap: () => Navigation.push(
        context,
        ContentPage(
          username: content.ownerUsername!,
          slug: content.slug!,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color:
              context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isComment ? '${content.body}' : '${content.title}',
              style: const TextStyle().copyWith(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigation.push(
                    context,
                    ProfileUserPage(
                      username: '${content.ownerUsername}',
                    ),
                  ),
                  child: Text('${content.ownerUsername}'),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${content.tabcoins} tabcoins · ${content.childrenDeepCount} comentários · ${timeago.format(date, locale: "pt-BR")}',
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
