class IngredientDTO {
  String id;
  String name;

  IngredientDTO({required this.id, required this.name});

  Map<String, dynamic> toMap() => {
    "_id": id,
    "nome": name,
  };

  static IngredientDTO fromMap(Map<String, dynamic> recipe) => IngredientDTO(
    id: recipe["_id"],
    name: recipe["nome"],
  );
}