import 'package:projects/config/database.dart';
import 'package:projects/model/ingredient.dart';
import 'package:sqflite/sqflite.dart';

Future<void> saveIngredient(Ingredient ingredient) async {
  final db = await configureDatabase();

  await db.insert(
    "ingredients",
    ingredient.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<Ingredient?> findIngredient(String ingredient) async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps =
      await db.query("ingredients", where: "name = ?", whereArgs: [ingredient]);
  return maps.isEmpty ? null : Ingredient.fromMap(maps[0]);
}

Future<void> removeSavedIngredient(String name) async {
  final db = await configureDatabase();

  await db.delete("ingredients", where: "name = ?", whereArgs: [name]);
}

Future<List<Ingredient>> savedIngredients() async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps = await db.query("ingredients");
  return List.generate(maps.length, (index) => Ingredient.fromMap(maps[index]));
}
