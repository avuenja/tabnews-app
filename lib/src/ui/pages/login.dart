import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/providers/user.dart';
import 'package:tabnews/src/ui/pages/register.dart';
import 'package:tabnews/src/ui/widgets/top_bar.dart';
import 'package:tabnews/src/utils/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                        cursorColor: AppColors.primaryColor,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
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
                                passwordTextController.text.isEmpty) {
                              return;
                            }

                            provider.login(
                              emailTextController.text,
                              passwordTextController.text,
                            );
                          },
                    child: Text(
                      provider.isLoading ? 'Aguarde...' : 'Login',
                      style: const TextStyle().copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Ainda não possui conta?'),
                    TextButton(
                      style: const ButtonStyle().copyWith(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                      onPressed: () => Navigation.push(context, RegisterPage()),
                      child: const Text('Criar cadastro'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
