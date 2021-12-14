import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projects/components/category_picker.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/components/recipe_vertical_card.dart';
import 'package:projects/components/vertical_center.dart';
import 'package:projects/config/toggles.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/networking/api.dart';
import 'package:projects/screens/all_recipes_page.dart';
import 'package:projects/util/no_glow_scroll.dart';

class HomePage extends StatelessWidget {
  static const categories = ["Tudo", "Almoço", "Janta", "Café da manhã", "Churrasco", "Sobremesas"];

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      body: PortraitHomeLayout(categories),
    );
  }
}

class ListAllRecipesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AllRecipesPage()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 3),
            )
          ]),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.add, size: 256, color: Colors.black38),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text("Todas as receitas", style: TextStyle(fontSize: 24.0, color: Colors.black38)),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.0)),
          ),
        ),
      ),
    );
  }
}

class PortraitHomeLayout extends StatefulWidget {
  List<String> categories;

  PortraitHomeLayout(this.categories);

  @override
  State<PortraitHomeLayout> createState() => _PortraitHomeLayoutState();
}

class _PortraitHomeLayoutState extends State<PortraitHomeLayout> {
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
          MingleTextInput(
            label: "Pesquisar",
            icon: Icon(Icons.search),
            onSubmitted: (value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              print(value);
              return AllRecipesPage(search: true, searchFor: value);
            })),
          ),
          if (Toggles.categoriesActive)
            SizedBox(
              height: 62,
              child: CategoryPicker(widget.categories),
            ),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowScroll(),
              child: FutureBuilder(
                future: RecipeAPI.fetchAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<RecipeDTO> fetchedRecipes = snapshot.data as List<RecipeDTO>;

                    if (fetchedRecipes.isNotEmpty) {
                      return ListView.builder(
                        itemCount: min(fetchedRecipes.length, 10),
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return index < 9 ? RecipeVerticalCard(recipe: fetchedRecipes[index]) : ListAllRecipesCard();
                        },
                      );
                    }
                  }

                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(64.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: VerticalCenter(
                          child: const Text(
                        "Nenhuma receita encontrada",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 32, color: Colors.black26),
                      )));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
