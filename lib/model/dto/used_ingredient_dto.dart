import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/model/used_ingredient.dart';

class UsedIngredientDTO {
  IngredientDTO ingredient;
  double quantity;
  String unit;

  UsedIngredientDTO({required this.ingredient, this.quantity = 0, this.unit = ""});

  UsedIngredient parse() => UsedIngredient(ingredient: ingredient.name, amount: quantity, measurementUnit: unit);

  Map<String, dynamic> toMap() => {
        "ingrediente": ingredient.toMap(),
        "quantidade": quantity,
        "unidade": unit,
      };

  static UsedIngredientDTO fromMap(Map<String, dynamic> recipe) {
    return UsedIngredientDTO(
      ingredient: IngredientDTO.fromMap(recipe["ingrediente"]),
      quantity: recipe["quantidade"] as double,
      unit: recipe["unidade"],
    );
  }
}
