import 'package:projects/model/dto/used_ingredient_dto.dart';

class RecipeDTO {
  String id;
  String name;
  List<UsedIngredientDTO> usedIngredients;
  List<String> preparation;
  String creatorId;
  String? picture;

  RecipeDTO({
    required this.id,
    required this.name,
    required this.usedIngredients,
    required this.preparation,
    required this.creatorId,
    required this.picture,
  });

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nome": name,
        "ingredientesUtilizados": usedIngredients,
        "preparo": preparation,
        "_idCriador": creatorId,
        "imagem": picture,
      };

  static RecipeDTO fromMap(Map<String, dynamic> recipe) {
    List<UsedIngredientDTO> usedIngredients =
        (recipe["ingredientesUtilizados"] as List<dynamic>)
            .map((object) => UsedIngredientDTO.fromMap(object))
            .toList();

    List<String> preparation = (recipe["preparo"] as List<dynamic>)
        .map((object) => object.toString())
        .toList();

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
