import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:projects/components/mingle_scaffold.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
        hideActionBar: true,
        body: Container(
          decoration: BoxDecoration(color: Colors.pink),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 128.0),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
                    child: Image(image: AssetImage("assets/images/logo.png")),
                  ),
                ),
              ),
              Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 64.0, horizontal: 32.0),
                child: Text(
                  "O Mingle é um app que te permite encontrar o que comer quando até você pensa que vai passar fome. "
                  "Com certeza em sua casa existem alguns ingredientes (por mais que não compatíveis entre si), e é nesses "
                  "ingredientes que você encontrará o seu lanchinho. Cadastre os ingredientes presentes na sua "
                  "casa e encontre o que comer agora mesmo!",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
