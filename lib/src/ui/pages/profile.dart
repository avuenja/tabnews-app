import 'package:flutter/material.dart';

import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/controllers/auth.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/ui/pages/my_contents.dart';
import 'package:tabnews/src/ui/pages/new_content.dart';
import 'package:tabnews/src/ui/pages/profile_edit.dart';
import 'package:tabnews/src/utils/navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> implements ViewAction {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();

    _authController = AuthController(this);
  }

  @override
  onSuccess({data}) {}

  @override
  onError({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

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
          ValueListenableBuilder(
            valueListenable: AppController.user,
            builder: (context, user, child) {
              return Column(
                children: [
                  Text(
                    '${user.username}',
                    style: const TextStyle().copyWith(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorContainer(Colors.blue),
                      Text('${user.tabcoins ?? 0}'),
                      const SizedBox(width: 10.0),
                      _buildColorContainer(Colors.green),
                      Text('${user.tabcash ?? 0}'),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 60.0),
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
            onTap: () => Navigation.push(context, const ProfileEditPage()),
            title: const Text('Editar perfil'),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            onTap: () => _authController.logout(),
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

  Widget _buildColorContainer(Color color) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.5),
      ),
      width: 12.0,
      height: 12.0,
    );
  }
}
