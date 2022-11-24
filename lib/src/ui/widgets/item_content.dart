import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabnews/src/ui/pages/content.dart';
import 'package:tabnews/src/utils/navigation.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/models/content.dart';

class ItemContent extends StatelessWidget {
  final int index;
  final Content content;

  const ItemContent({
    super.key,
    required this.index,
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}.',
                  style: const TextStyle().copyWith(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10.0),
                Flexible(
                  child: Text(
                    isComment ? '${content.body}' : '${content.title}',
                    style: const TextStyle().copyWith(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${content.tabcoins} tabcoins · ${content.ownerUsername} · ${timeago.format(date, locale: "pt-BR")}',
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
