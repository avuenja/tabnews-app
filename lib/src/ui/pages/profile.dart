import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tabnews/src/providers/user.dart';
import 'package:tabnews/src/ui/pages/my_contents.dart';
import 'package:tabnews/src/ui/pages/new_content.dart';
import 'package:tabnews/src/ui/pages/profile_edit.dart';
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
            '${UserProvider().user?.username}',
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
          ListTile(
            onTap: () => Navigation.push(context, const NewContentPage()),
            title: const Text('Publicar novo conteúdo'),
          ),
          ListTile(
            onTap: () => Navigation.push(context, ProfileEditPage()),
            title: const Text('Editar perfil'),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            onTap: () =>
                Provider.of<UserProvider>(context, listen: false).logout(),
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
