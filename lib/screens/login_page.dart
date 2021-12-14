import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:projects/components/mingle_large_button.dart';
import 'package:projects/components/mingle_snackbar.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/config/authentication.dart';
import 'package:projects/dao/user_dao.dart';
import 'package:projects/model/user.dart';
import 'package:projects/util/no_glow_scroll.dart';

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
              behavior: NoGlowScroll(),
              child: ListView(
                children: [
                  if (_isRegister)
                    MingleTextInput(
                      label: "Username",
                      icon: Icon(Icons.account_circle),
                      controller: _usernameController,
                      validator: (value) {
                        if (!_isRegister) return null;

                        if (value.length < 5) {
                          return "O username precisa conter ao menos 5 digitos";
                        }
                      },
                    ),
                  MingleTextInput(
                    label: "Email",
                    icon: Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (!value!.contains("@") || !value.contains(".")) {
                        return "O email fornecido é inválido";
                      }
                    },
                  ),
                  MingleTextInput(
                    label: "Senha",
                    icon: Icon(Icons.password),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (!_isRegister) return null;

                      if (value.length < 7) {
                        return "A senha precisa conter ao menos 7 dígitos";
                      }

                      bool containsLetter = false;
                      bool containsNumber = false;

                      for (int i = 0; i < value.length; i++) {
                        if (!containsLetter) {
                          for (int n = 0; n < 26; n++) {
                            if (String.fromCharCode(value.codeUnitAt(i)) == String.fromCharCode('a'.codeUnitAt(0) + n)) {
                              containsLetter = true;
                              break;
                            }
                          }
                        }
                        if (!containsNumber) {
                          for (int n = 0; n < 10; n++) {
                            if (String.fromCharCode(value.codeUnitAt(i)) == n.toString()) {
                              containsNumber = true;
                              break;
                            }
                          }
                        }
                        if (containsLetter && containsNumber) break;
                      }

                      if (!containsLetter || !containsNumber) {
                        return "A senha precisa conter letras e números";
                      }
                    },
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
                    child: Text(_isRegister ? "Já tem uma conta?" : "Ainda não tem uma conta?"),
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
                onClick: () async {
                  User user = User(
                    username: _isRegister ? _usernameController.text : null,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  User? found = await findUser(user.email);
                  if (_isRegister) {
                    if (found != null) {
                      ScaffoldMessenger.of(context).showSnackBar(MingleSnackbar(content: Text("Usuário fornecido já existe")));
                      return;
                    }
                    await createUserAndAuthenticate(user);
                  } else {
                    if (found == null) {
                      ScaffoldMessenger.of(context).showSnackBar(MingleSnackbar(content: Text("Usuário não encontrado")));
                      return;
                    }
                    await findUserAndAuthenticate(user);
                  }

                  if (await isAuthenticated()) {
                    await saveUser(user.email);
                    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(MingleSnackbar(content: Text("Credenciais incorretas")));
                },
              ),
              InkWell(
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("ou "),
                      Text(
                        "continuar sem uma conta",
                        style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
