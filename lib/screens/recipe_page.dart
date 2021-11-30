import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/components/flat_text.dart';
import 'package:projects/components/ingredient_indicator.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/util/no_glow_scroll.dart';

class RecipePage extends StatelessWidget {
  RecipeDTO recipe;

  RecipePage(this.recipe);

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      title: recipe.name,
      hideActionBar: true,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlowScroll(),
          child: ListView(
            children: [
              if (recipe.picture != null)
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Image.network(
                    recipe.picture!,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text("Ingredientes",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6A515E))),
              ),
              Container(
                constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: MediaQuery.of(context).size.height * 0.3),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return IngredientIndicator(
                      recipe.usedIngredients[index].parse(),
                    );
                  },
                  itemCount: recipe.usedIngredients.length,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text("Modo de preparo",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6A515E))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: 0,
                      maxHeight: MediaQuery.of(context).size.height * 0.4),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text((index + 1).toString()),
                        title: FlatText(recipe.preparation[index]),
                      );
                    },
                    itemCount: recipe.preparation.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
