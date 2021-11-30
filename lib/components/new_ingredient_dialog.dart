import 'package:flutter/material.dart';
import 'package:projects/model/used_ingredient.dart';
import 'package:projects/screens/add_ingredient_page.dart';

class NewIngredientDialog extends StatelessWidget {
  List<UsedIngredient> ingredients;
  VoidCallback? update;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _measurementUnitController = TextEditingController();

  NewIngredientDialog(this.ingredients, {this.update});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        children: [
          ...AddIngredientContent(
            context,
            nameController: _nameController,
            amountController: _amountController,
              measurementUnitController: _measurementUnitController
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("cancelar"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.grey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    ingredients.add(UsedIngredient(
                      ingredient: _nameController.text,
                      amount: double.parse(_amountController.text),
                      measurementUnit: _measurementUnitController.text,
                    ));

                    if (update != null) update!();

                    Navigator.pop(context);
                  },
                  child:
                      Text("adicionar", style: TextStyle(color: Colors.pink)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.pink),
                  ),
                ),
              ),
            ],
          ),
        ]);
  }
}
