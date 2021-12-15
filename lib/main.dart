import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/authentication.dart';
import 'dao/recipes_dao.dart';
import 'model/recipe.dart';
import 'screens/about_page.dart';
import 'screens/add_ingredient_page.dart';
import 'screens/add_recipe_page.dart';
import 'screens/home_page.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/menu_page.dart';
import 'screens/my_ingredients_page.dart';
import 'screens/my_recipes_page.dart';
import 'screens/profile_page.dart';
import 'screens/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDhR89fXDLnKW3kfPbCXkYJzdTgHip9JTU",
    appId: "1:850271286647:android:4a392dc4824a4745779d72",
    messagingSenderId: "850271286647",
    projectId: "mingle-5f002",
  ));

  runApp(MingleApplication());
}

class MingleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        return MaterialApp(
          initialRoute: snapshot.data == true ? "/home" : "/",
          routes: {
            "/": (context) => LandingPage(),
            "/login": (context) => LoginPage(),
            "/home": (context) => HomePage(),
            "/find": (context) => SearchPage(),
            "/menu": (context) => MenuPage(),
            "/about": (context) => AboutPage(),
            "/profile": (context) => ProfilePage(),
            "/add/ingredient": (context) => AddIngredientPage(),
            "/add/recipe": (context) => AddRecipePage(),
            "/my/ingredients": (context) => MyIngredientsPage(),
            "/my/recipes": (context) => MyRecipesPage(),
          },
          theme: ThemeData(
            fontFamily: "Quicksand",
          ),
        );
      },
    );
  }
}
