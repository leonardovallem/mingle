import 'package:projects/config/database.dart';
import 'package:projects/model/ingredient.dart';
import 'package:projects/model/used_ingredient.dart';
import 'package:sqflite/sqflite.dart';

import 'ingredients_dao.dart';

Future<void> saveUsedIngredient(UsedIngredient usedIngredient) async {
  Ingredient? ingredient = await findIngredient(usedIngredient.ingredient);
  if(ingredient == null) await saveIngredient(Ingredient(usedIngredient.ingredient));

  final db = await configureDatabase();

  await db.insert(
    "used_ingredients",
    usedIngredient.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<UsedIngredient?> findEquivalentIngredient(
    UsedIngredient usedIngredient) async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps = await db.query("used_ingredients",
      where: "ingredient = ? AND "
             "amount = ? AND "
             "measurement_unit = ?",
      whereArgs: [
        usedIngredient.ingredient,
        usedIngredient.amount,
        usedIngredient.measurementUnit,
      ]);
  return maps.isEmpty ? null : UsedIngredient.fromMap(maps[0]);
}

Future<void> removeSavedUsedIngredient(String ingredient) async {
  final db = await configureDatabase();

  await db.delete("used_ingredients",
      where: "ingredient = ?", whereArgs: [ingredient]);
}

Future<List<UsedIngredient>> savedUsedIngredients() async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps = await db.query("used_ingredients");
  return List.generate(
    maps.length,
    (index) => UsedIngredient.fromMap(maps[index]),
  );
}
