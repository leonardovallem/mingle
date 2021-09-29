import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projects/components/mingle_large_button.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/model/user.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isRegister = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        foregroundColor: Color(0xFF69515D),
        title: Text(_isRegister ? "Cadastrar" : "Entrar"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ScrollConfiguration(
                  behavior: NoScrollGlow(),
                  child: ListView(
                    children: [
                      if (_isRegister)
                        MingleTextInput(
                          label: "Username",
                          icon: Icon(Icons.account_circle),
                          controller: _usernameController,
                        ),
                      MingleTextInput(
                        label: "Email",
                        icon: Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      MingleTextInput(
                        label: "Senha",
                        icon: Icon(Icons.password),
                        controller: _passwordController,
                      ),
                    ],
                  ),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(_isRegister
                        ? "Já tem uma conta?"
                        : "Ainda não tem uma conta?"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _isRegister = !_isRegister);
                    },
                    child: Text(_isRegister ? "Entrar" : "Cadastrar"),
                  )
                ],
              ),
              MingleLargeButton(
                label: _isRegister ? "Cadastrar" : "Login",
                onClick: () {
                  User user = User(
                    username: _isRegister ? _usernameController.text : null,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child,
      AxisDirection axisDirection) {
    return child;
  }
}
