import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/providers/user.dart';
import 'package:tabnews/src/ui/widgets/top_bar.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Consumer<UserProvider>(
              builder: (context, provider, _) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: provider.isRegister
                    ? [
                        Text(
                          'Confira seu e-mail: ${emailTextController.text}',
                          style: const TextStyle().copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          'Você receberá um link para confirmar seu cadastro e ativar a sua conta.',
                        ),
                      ]
                    : [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enableSuggestions: false,
                                autocorrect: false,
                                cursorColor: context.isDarkMode
                                    ? Colors.white
                                    : AppColors.primaryColor,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: 'Nome de usuário',
                                ),
                                controller: usernameTextController,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: context.isDarkMode
                                    ? Colors.white
                                    : AppColors.primaryColor,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: 'Email',
                                ),
                                controller: emailTextController,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: true,
                                cursorColor: context.isDarkMode
                                    ? Colors.white
                                    : AppColors.primaryColor,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: 'Senha',
                                ),
                                controller: passwordTextController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        ElevatedButton(
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
                                  if (usernameTextController.text.isEmpty ||
                                      emailTextController.text.isEmpty ||
                                      passwordTextController.text.isEmpty) {
                                    return;
                                  }

                                  provider.register(
                                    usernameTextController.text,
                                    emailTextController.text,
                                    passwordTextController.text,
                                  );
                                },
                          child: Text(
                            provider.isLoading
                                ? 'Aguarde...'
                                : 'Criar cadastro',
                            style: const TextStyle().copyWith(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
