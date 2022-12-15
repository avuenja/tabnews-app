import 'package:flutter/material.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/controllers/auth.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/ui/pages/register.dart';
import 'package:tabnews/src/ui/pages/use_terms.dart';
import 'package:tabnews/src/utils/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements ViewAction {
  late final AuthController _authController;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

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
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              ValueListenableBuilder(
                valueListenable: _authController.isLoading,
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
                        : () => _authController.login(
                              emailTextController.text,
                              passwordTextController.text,
                            ),
                    child: Text(
                      isLoading ? 'Aguarde...' : 'Login',
                      style: const TextStyle().copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ainda não possui conta?',
                    style: const TextStyle().copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    style: const ButtonStyle().copyWith(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        context.isDarkMode
                            ? Colors.white
                            : AppColors.primaryColor,
                      ),
                    ),
                    onPressed: () => Navigation.push(
                      context,
                      const RegisterPage(),
                    ),
                    child: const Text('Criar cadastro'),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              TextButton(
                style: const ButtonStyle().copyWith(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    context.isDarkMode ? Colors.white : AppColors.primaryColor,
                  ),
                ),
                onPressed: () => Navigation.push(
                  context,
                  UseTermsPage(),
                ),
                child: const Text('Termos de Uso'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
