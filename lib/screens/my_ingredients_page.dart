import 'package:flutter/material.dart';
import 'package:projects/components/flat_text.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/config/toggles.dart';
import 'package:projects/dao/owned_ingredients_dao.dart';
import 'package:projects/model/owned_ingredient.dart';

class MyIngredientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      title: "Meus ingredientes",
      hideActionBar: true,
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          List<OwnedIngredient> ingredients = snapshot.data as List<OwnedIngredient>;

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
                OwnedIngredient ingredient = ingredients[index];
                return ListTile(
                  title: FlatText(ingredient.ingredient),
                  subtitle: Toggles.partitionedIngredientsActive ? Text("${ingredient.amount}${ingredient.measurementUnit}") : null,
                );
              },
              itemCount: ingredients.length);
        },
        future: savedOwnedIngredients(),
      ),
    );
  }
}
