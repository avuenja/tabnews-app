import 'package:flutter/material.dart';

import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/services/api.dart';
import 'package:tabnews/src/widgets/item_card.dart';
import 'package:tabnews/src/widgets/layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Content> contents;
  final api = Api();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _getContents();
  }

  Future<void> _getContents() async {
    var content = await api.fetchContents();

    setState(() {
      contents = content;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutApp(
      pullToRefresh: _getContents,
      isLoading: isLoading,
      body: isLoading
          ? const SizedBox()
          : ListView.builder(
              itemCount: contents.length,
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) => ItemCard(
                index: index,
                content: contents[index],
              ),
            ),
    );
  }
}
