import 'package:projects/model/dto/used_ingredient_dto.dart';

class RegisteredIngredientDTO {
  String? id;
  String owner;
  UsedIngredientDTO usedIngredient;

  RegisteredIngredientDTO({this.id, required this.owner, required this.usedIngredient});

  Map<String, dynamic> toMap() {
    var map = {
      "idUsuario": owner,
      "ingredienteUtilizado": usedIngredient.toMap(),
    };

    if (id != null) map.addAll({"_id": id!});
    return map;
  }

  static RegisteredIngredientDTO fromMap(Map<String, dynamic> recipe) {
    return RegisteredIngredientDTO(
      id: recipe["_id"],
      owner: recipe["idUsuario"],
      usedIngredient: UsedIngredientDTO.fromMap(recipe["ingredienteUtilizado"]),
    );
  }
}
