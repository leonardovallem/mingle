import 'package:flutter/material.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/config/authentication.dart';
import 'package:projects/dao/user_dao.dart';
import 'package:projects/model/user.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User?> getUserInfo() async {
      String? email = await currentUser();
      return email == null ? null : findUser(email);
    }

    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Expanded(child: Center(child: CircularProgressIndicator()));

        var user = snapshot.data as User;

        return MingleScaffold(
          hideActionBar: true,
          title: user.username,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              const Text("Email", style: TextStyle(fontSize: 24)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(user.email, style: TextStyle(fontSize: 28), textAlign: TextAlign.center),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: Color(0xFFFAFAFA),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
