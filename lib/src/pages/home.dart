import 'package:flutter/material.dart';
import 'package:tabnews/src/models/content.dart';
import 'package:tabnews/src/services/api.dart';
import 'package:tabnews/src/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Content> contents = [];
  final api = Api();

  @override
  void initState() {
    super.initState();

    getContents();
  }

  getContents() async {
    var content = await api.fetchContents();

    setState(() {
      contents = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabNews'),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
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
