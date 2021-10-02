import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/screens/list_item.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
        hideActionBar: true,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListItem(title: Text("Perfil (em breve)")),
                  ListItem(
                    title: Text("Sobre"),
                    onClick: () => Navigator.pushNamed(context, "/about"),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => false),
                  child: Text("Sair"),
                ),
              ),
            )
          ],
        ));
  }
}
