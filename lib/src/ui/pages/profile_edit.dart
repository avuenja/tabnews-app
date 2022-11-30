import 'package:flutter/material.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/controllers/app.dart';
import 'package:tabnews/src/controllers/user.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/ui/layouts/page.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage>
    implements ViewAction {
  late final UserController _userController;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameTextController = TextEditingController(
    text: AppController.user.value.username,
  );
  final TextEditingController emailTextController = TextEditingController(
    text: AppController.user.value.email,
  );

  @override
  void initState() {
    super.initState();

    _userController = UserController(this);
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
    return PageLayout(
      onRefresh: () async {},
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: AppColors.primaryColor,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Nome de usuário',
                  ),
                  controller: usernameTextController,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: AppColors.primaryColor,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Email',
                  ),
                  controller: emailTextController,
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _userController.notification,
                      builder: (context, notifications, child) {
                        return Checkbox(
                          fillColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor,
                          ),
                          value: notifications,
                          onChanged: _userController.setNotifications,
                        );
                      },
                    ),
                    const Text('Receber notificações por email'),
                  ],
                ),
                const SizedBox(height: 30.0),
                ValueListenableBuilder(
                  valueListenable: _userController.isLoading,
                  builder: (context, isLoading, child) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor.withOpacity(
                            isLoading ? 0.5 : 1.0,
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () => _userController.update(
                                usernameTextController.text,
                                emailTextController.text,
                              ),
                      child: Text(
                        isLoading ? 'Aguarde...' : 'Salvar',
                        style: const TextStyle().copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
