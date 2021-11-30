import 'package:projects/util/list_items_controller.dart';

class Ingredient {
  String name;

  Ingredient(this.name);

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
