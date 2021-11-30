import 'package:flutter/material.dart';
import 'package:projects/components/ingredient_indicator.dart';
import 'package:projects/components/new_ingredient_dialog.dart';
import 'package:projects/model/used_ingredient.dart';
import 'package:projects/util/no_glow_scroll.dart';

import 'mingle_large_button.dart';

class IngredientsList extends StatefulWidget {
  const IngredientsList({Key? key}) : super(key: key);

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  List<UsedIngredient> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0x33AA4400)),
      child: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowScroll(),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return IngredientIndicator(_ingredients[index]);
                },
                itemCount: _ingredients.length,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MingleLargeButton(
              label: "adicionar ingrediente",
              icon: Icons.add,
              onClick: () => showDialog(
                context: context,
                builder: (context) => NewIngredientDialog(_ingredients,
                    update: () => setState(() {})),
              ),
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}
