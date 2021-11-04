import 'package:flutter/material.dart';
import 'package:projects/config/authentication.dart';
import 'package:projects/dao/recipes_dao.dart';
import 'package:projects/model/recipe.dart';

import 'screens/about_page.dart';
import 'screens/home_page.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/menu_page.dart';
import 'screens/profile_page.dart';
import 'screens/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  List<Recipe> recipes = [
    Recipe(name: "Brigadeiro de Fubá", publisher: "_antonov", averageRating: 4.5, photo: "https://i1.wp.com/www.flamboesa.com.br/wp-content/uploads/2017/10/brigadeiro-doce-de-leite4072.jpg"),
    Recipe(name: "Sopa de cebolinha", publisher: "anav_andrade", averageRating: 4.6, photo: "https://t1.uc.ltmcdn.com/pt/images/6/3/8/img_como_fazer_caldo_verde_7836_orig.jpg"),
    Recipe(name: "Suco roxo", publisher: "joaovictormarques", averageRating: 3.9, photo: "https://xtudoreceitas.com/wp-content/uploads/Sucos-Detox-Beterraba-500x400.jpg"),
    Recipe(name: "Escondidinho de brócolis", publisher: "mariavitorias", averageRating: 4.1, photo: "http://3.bp.blogspot.com/-kGs1anoEMsM/VL0dlYfhlUI/AAAAAAAADQw/gQZjXMg9-rs/s1600/escondidinho_brocolis.JPG"),
  ];


  savedRecipes().then((savedRecipes) {
    if(savedRecipes.isNotEmpty) return;
    recipes.forEach((recipe) => saveRecipe(recipe));
  });

  runApp(MingleApplication());
}

class MingleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return const CircularProgressIndicator();

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
          },
          theme: ThemeData(
            fontFamily: "Quicksand",
          ),
        );
      },
    );
  }
}
