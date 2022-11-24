import 'package:flutter/material.dart';

import 'package:tabnews/src/ui/pages/my_contents.dart';
import 'package:tabnews/src/utils/navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'avuenja',
            style: const TextStyle().copyWith(
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 80.0),
          ListTile(
            onTap: () => Navigation.push(context, const MyContentsPage()),
            title: const Text('Meu conteúdo'),
          ),
          const Divider(color: Colors.grey),
          const ListTile(
            onTap: null,
            title: Text('Publicar novo conteúdo'),
          ),
          const ListTile(
            onTap: null,
            title: Text('Editar perfil'),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            onTap: () {},
            title: Text(
              'Deslogar',
              style: const TextStyle().copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
