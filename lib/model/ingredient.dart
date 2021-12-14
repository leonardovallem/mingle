

import 'package:projects/model/dto/ingredient_dto.dart';

class Ingredient {
  String name;

  Ingredient(this.name);

  IngredientDTO toDTO() => IngredientDTO(name: name);

  Map<String, dynamic> toMap() => {
        "name": name,
      };

  static Ingredient fromMap(Map<String, dynamic> ingredient) => Ingredient(ingredient["name"]);

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    Ingredient obj = other as Ingredient;
    return obj.name == name;
  }
}
