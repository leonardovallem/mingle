import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projects/components/category_picker.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/components/recipe_horizontal_card.dart';
import 'package:projects/components/recipe_vertical_card.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/networking/api.dart';
import 'package:projects/util/no_glow_scroll.dart';

Widget buildRecipesList({bool horizontal = false}) {
  return Expanded(
    child: ScrollConfiguration(
      behavior: NoGlowScroll(),
      child: FutureBuilder(
        future: fetchAllRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                  child: Column(
                children: [
                  const Icon(Icons.warning, size: 128),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.error.toString()),
                  )
                ],
              )),
            );
          }

          if (!snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.all(64.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          List<RecipeDTO> fetchedRecipes = snapshot.data as List<RecipeDTO>;

          return ListView.builder(
            itemCount: fetchedRecipes.length,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => horizontal
                ? RecipeHorizontalCard(recipe: fetchedRecipes[index])
                : RecipeVerticalCard(recipe: fetchedRecipes[index]),
          );
        },
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  static const categories = [
    "Tudo",
    "Almoço",
    "Janta",
    "Café da manhã",
    "Churrasco",
    "Sobremesas"
  ];

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      body: MediaQuery.of(context).size.width > 600 ||
              MediaQuery.of(context).orientation == Orientation.landscape
          ? LandscapeHomeLayout(categories)
          : PortraitHomeLayout(categories),
    );
  }
}

class PortraitHomeLayout extends StatelessWidget {
  List<String> categories;

  PortraitHomeLayout(this.categories);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text("Todas as receitas",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A515E),
                )),
          ),
          MingleTextInput(label: "Pesquisar", icon: Icon(Icons.search)),
          SizedBox(
            height: 62,
            child: CategoryPicker(categories),
          ),
          buildRecipesList()
        ],
      ),
    );
  }
}

class LandscapeHomeLayout extends StatelessWidget {
  List<String> categories;

  LandscapeHomeLayout(this.categories);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: NoGlowScroll(),
            child: ListView(
              children: [
                const Center(
                  child: Text("Todas as receitas",
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A515E),
                      )),
                ),
                MingleTextInput(label: "Pesquisar", icon: Icon(Icons.search)),
                SizedBox(
                  height: 62,
                  child: CategoryPicker(categories),
                ),
              ],
            ),
          ),
        ),
        buildRecipesList(horizontal: true),
      ],
    );
  }
}
