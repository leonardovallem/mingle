import 'package:flutter/material.dart';

import 'screens/about_page.dart';
import 'screens/home_page.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/search_page.dart';
import 'screens/menu_page.dart';

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
        "/home": (context) => HomePage(),
        "/find": (context) => SearchPage(),
        "/menu": (context) => MenuPage(),
        "/about": (context) => AboutPage(),
      },
      theme: ThemeData(
        fontFamily: "Quicksand",
      ),
    );
  }
}
