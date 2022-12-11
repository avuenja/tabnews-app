import 'package:flutter/material.dart';

import 'package:tabnews/src/utils/open_link.dart';

class SourceUrl extends StatelessWidget {
  final String sourceUrl;

  const SourceUrl({super.key, required this.sourceUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Fonte: ',
          style: const TextStyle().copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => OpenLink.open(
              sourceUrl,
              context,
            ),
            child: Text(
              sourceUrl,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle().copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
