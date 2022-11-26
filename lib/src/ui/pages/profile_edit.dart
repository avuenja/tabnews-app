import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/providers/user.dart';
import 'package:tabnews/src/ui/layouts/page.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({super.key});

  final TextEditingController usernameTextController = TextEditingController(
    text: UserProvider().user?.username,
  );
  final TextEditingController emailTextController = TextEditingController(
    text: UserProvider().user?.email,
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      onRefresh: () async {},
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                    Checkbox(
                      fillColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                      value: UserProvider().user?.notifications,
                      onChanged: Provider.of<UserProvider>(context)
                          .toggleNotifications,
                    ),
                    const Text('Receber notificações por email'),
                  ],
                ),
                const SizedBox(height: 30.0),
                Consumer<UserProvider>(
                  builder: (context, provider, _) => ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor.withOpacity(
                          provider.isLoading ? 0.5 : 1.0,
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
                    onPressed: provider.isLoading
                        ? null
                        : () {
                            if (emailTextController.text.isEmpty ||
                                usernameTextController.text.isEmpty) {
                              return;
                            }

                            provider.profileUpdate(
                              emailTextController.text,
                              usernameTextController.text,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Perfil atualizado com sucesso!',
                                ),
                              ),
                            );
                          },
                    child: Text(
                      provider.isLoading ? 'Aguarde...' : 'Salvar',
                      style: const TextStyle().copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
