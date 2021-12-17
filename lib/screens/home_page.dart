import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projects/components/category_picker.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/components/recipe_vertical_card.dart';
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
            onSubmitted: (value) =>
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllRecipesPage(search: true, searchFor: value))),
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
                      var _scrollController = ScrollController();
                      var count = min(fetchedRecipes.length, 10) + 1;

                      return ListView.builder(
                        itemCount: count,
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          if (index < count - 1) return RecipeVerticalCard(recipe: fetchedRecipes[index]);

                          return index == 10
                              ? ListAllRecipesCard()
                              : Container(
                                margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 128),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.25),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                child: InkWell(
                                  onTap: () => setState(() {
                                    _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeInOutQuint);
                                  }),
                                  child: const Padding(
                                      padding: EdgeInsets.all(32),
                                      child: Icon(Icons.restart_alt, color: Colors.black54, size: 32),
                                    ),
                                ),
                              );
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Nenhuma receita encontrada",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 32, color: Colors.black26),
                          ),
                          OutlinedButton(onPressed: () => setState(() {}), child: Icon(Icons.restart_alt))
                        ],
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
