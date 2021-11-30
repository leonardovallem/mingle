import 'package:projects/model/used_ingredient.dart';

class OwnedIngredient extends UsedIngredient {
  String owner;

  OwnedIngredient({
    required ingredient,
    required amount,
    required measurementUnit,
    required this.owner,
  }) : super(ingredient: ingredient, amount: amount, measurementUnit: measurementUnit);

  Map<String, dynamic> toMap() => {
        "ingredient": ingredient,
        "amount": amount,
        "measurement_unit": measurementUnit,
        "owner": owner,
      };

  static OwnedIngredient fromMap(Map<String, dynamic> usedIngredient) =>
      OwnedIngredient(
        ingredient: usedIngredient["ingredient"],
        amount: usedIngredient["amount"],
        measurementUnit: usedIngredient["measurement_unit"],
        owner: usedIngredient["owner"],
      );

  UsedIngredient toUsedIngredient() {
    return UsedIngredient(ingredient: ingredient, amount: amount, measurementUnit: measurementUnit);
  }
}
