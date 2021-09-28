import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';

void main() {
  runApp(MingleApplication());
}

class MingleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => LandingPage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
