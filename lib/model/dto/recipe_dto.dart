import 'package:projects/model/dto/used_ingredient_dto.dart';

class RecipeDTO {
  String? id;
  String? name;
  List<UsedIngredientDTO> usedIngredients;
  List<String> preparation;
  String? creatorId;
  String? picture;

  RecipeDTO({
    this.id,
    required this.name,
    required this.usedIngredients,
    required this.preparation,
    required this.creatorId,
    this.picture,
  });

  Map<String, dynamic> toMap() {
    var map = {
      "nome": name,
      "ingredientesUtilizados": usedIngredients.map((ui) => ui.toMap()).toList(),
      "preparo": preparation,
      "_idCriador": creatorId,
      "imagem": picture,
    };

    if (id != null) map.addAll({"_id": id!});
    return map;
  }

  static RecipeDTO fromMap(Map<String, dynamic> recipe) {
    var usedIngredientsJson = recipe["ingredientesUtilizados"];
    var preparationJson = recipe["preparo"];

    List<UsedIngredientDTO> usedIngredients =
        (usedIngredientsJson as List<dynamic>).map((object) => UsedIngredientDTO.fromMap(object)).toList();

    List<String> preparation = (preparationJson as List<dynamic>).map((object) => object.toString()).toList();

    return RecipeDTO(
      id: recipe["_id"],
      name: recipe["nome"],
      usedIngredients: usedIngredients,
      preparation: preparation,
      creatorId: recipe["_idCriador"],
      picture: recipe["imagem"],
    );
  }
}
