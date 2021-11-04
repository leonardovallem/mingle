import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/config/authentication.dart';
import 'package:projects/screens/list_item.dart';

class MenuPage extends StatelessWidget {
  final Future<bool> _authenticated = isAuthenticated();

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
        hideActionBar: true,
        body: FutureBuilder(
          future: _authenticated,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ProfileListItem(),
                      ListItem(
                        title: Text("Sobre"),
                        onClick: () => Navigator.pushNamed(context, "/about"),
                      )
                    ],
                  ),
                ),
                if (snapshot.data == true)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => false);
                        },
                        child: Text("Sair"),
                      ),
                    ),
                  )
              ],
            );
          },
        ));
  }
}

class ProfileListItem extends StatelessWidget {
  bool authenticated = false;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      title: Text(authenticated ? "Perfil" : "Fazer login"),
      onClick: () {
        if (authenticated) {
          Navigator.pushNamed(context, "/profile");
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        }
      },
    );
  }
}
