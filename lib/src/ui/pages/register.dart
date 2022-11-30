import 'package:flutter/material.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/controllers/auth.dart';
import 'package:tabnews/src/extensions/dark_mode.dart';
import 'package:tabnews/src/interfaces/view_action.dart';
import 'package:tabnews/src/ui/widgets/top_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> implements ViewAction {
  late final AuthController _authController;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

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
    return Scaffold(
      appBar: const AppTopBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ValueListenableBuilder(
              valueListenable: _authController.isRegister,
              builder: (context, isRegister, child) {
                if (isRegister) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                    ],
                  );
                } else {
                  return child ?? const SizedBox();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                            : () => _authController.register(
                                  usernameTextController.text,
                                  emailTextController.text,
                                  passwordTextController.text,
                                ),
                        child: Text(
                          isLoading ? 'Aguarde...' : 'Criar cadastro',
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
      ),
    );
  }
}
