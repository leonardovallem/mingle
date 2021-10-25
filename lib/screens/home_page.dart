import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:projects/components/action_bar.dart';
import 'package:projects/components/category_picker.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/category_chip.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/components/recipe_horizontal_card.dart';
import 'package:projects/components/recipe_vertical_card.dart';
import 'package:projects/model/recipe.dart';
import 'package:projects/util/no_glow_scroll.dart';

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
          Expanded(
            child: ScrollConfiguration(
              behavior: NoScrollGlow(),
              child: ListView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                children: [
                  RecipeVerticalCard(
                      recipe: Recipe(
                    name: "Sopa de Couve",
                    publisher: "_jaum_jaum",
                    averageRating: 4.8,
                  )),
                  RecipeVerticalCard(
                      recipe: Recipe(
                    name: "Angu frito",
                    publisher: "_annxrchism",
                    averageRating: 2.7,
                  )),
                  RecipeVerticalCard(
                      recipe: Recipe(
                    name: "Arroz de Macarrão",
                    publisher: "mlkcabral",
                    averageRating: 5.1,
                  )),
                ],
              ),
            ),
          )
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
            behavior: NoScrollGlow(),
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
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoScrollGlow(),
                  child: ListView(
                    clipBehavior: Clip.none,
                    children: [
                      RecipeHorizontalCard(
                          recipe: Recipe(
                        name: "Sopa de Couve",
                        publisher: "_jaum_jaum",
                        averageRating: 4.8,
                      )),
                      RecipeHorizontalCard(
                          recipe: Recipe(
                        name: "Angu frito",
                        publisher: "_annxrchism",
                        averageRating: 2.7,
                      )),
                      RecipeHorizontalCard(
                          recipe: Recipe(
                        name: "Arroz de Macarrão",
                        publisher: "mlkcabral",
                        averageRating: 5.1,
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
