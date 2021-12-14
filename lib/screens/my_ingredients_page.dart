import 'package:flutter/material.dart';
import 'package:projects/components/flat_text.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/config/toggles.dart';
import 'package:projects/dao/owned_ingredients_dao.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/model/owned_ingredient.dart';
import 'package:projects/networking/api.dart';

class MyIngredientsPage extends StatelessWidget {
  bool useLocal;

  MyIngredientsPage({this.useLocal = false});

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      title: "Meus ingredientes",
      hideActionBar: true,
      body: FutureBuilder(
        future: useLocal ? savedOwnedIngredients() : IngredientAPI.fetchFromCurrentUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          var ingredients = useLocal ? snapshot.data as List<OwnedIngredient> : snapshot.data as List<IngredientDTO>;

          if (ingredients.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 192.0),
              child: Text(
                "Você ainda não tem ingredientes",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
              itemBuilder: (context, index) {
                if(useLocal) {
                  OwnedIngredient ingredient = ingredients[index] as OwnedIngredient;
                  return ListTile(
                    title: FlatText(ingredient.ingredient),
                    subtitle: Toggles.partitionedIngredientsActive ? Text("${ingredient.amount}${ingredient.measurementUnit}") : null,
                  );
                }

                IngredientDTO ingredient = ingredients[index] as IngredientDTO;
                return ListTile(
                  title: FlatText(ingredient.name),
                );
              },
              itemCount: ingredients.length);
        },
      ),
    );
  }
}
