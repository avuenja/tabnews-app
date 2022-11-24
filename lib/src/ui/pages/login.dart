import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:tabnews/src/constants.dart';
import 'package:tabnews/src/login_state.dart';
import 'package:tabnews/src/models/auth.dart';
import 'package:tabnews/src/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final api = ApiAuth();

  void saveLoginState(BuildContext context) async {
    var auth = await api.postLogin(
      emailTextController.text,
      passwordTextController.text,
    );

    if (auth.id!.isNotEmpty) {
      Provider.of<LoginState>(context, listen: false).loggedIn = true;
      Provider.of<LoginState>(context, listen: false).session = auth;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            SvgPicture.asset(
              'lib/assets/logo.svg',
              semanticsLabel: 'TabNews',
            ),
            const SizedBox(width: 10.0),
            const Text('TabNews'),
          ],
        ),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
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
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
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
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
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
                      AppColors.primaryColor,
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
                  onPressed: () {
                    saveLoginState(context);
                  },
                  child: Text(
                    'Login',
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
    );
  }
}
