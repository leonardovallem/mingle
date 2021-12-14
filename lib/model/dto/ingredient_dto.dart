class IngredientDTO {
  String? id;
  String name;

  IngredientDTO({this.id, required this.name});

  @override
  bool operator ==(Object other) => name == (other as IngredientDTO).name;

  @override
  String toString() {
    return name;
  }

  Map<String, dynamic> toMap() {
    var map = {"nome": name};
    if (id != null) map.addAll({"_id": id!});
    return map;
  }

  static IngredientDTO fromMap(Map<String, dynamic> recipe) => IngredientDTO(
        id: recipe["_id"],
        name: recipe["nome"],
      );
}
