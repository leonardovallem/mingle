import 'package:projects/config/database.dart';
import 'package:projects/dao/used_ingredients_dao.dart';
import 'package:projects/model/owned_ingredient.dart';
import 'package:projects/model/used_ingredient.dart';
import 'package:sqflite/sqflite.dart';

Future<void> saveOwnedIngredient(OwnedIngredient ownedIngredient) async {
  UsedIngredient? usedIngredient = await findEquivalentIngredient(ownedIngredient);
  if(usedIngredient == null) await saveUsedIngredient(ownedIngredient.toUsedIngredient());

  final db = await configureDatabase();

  await db.insert(
    "owned_ingredients",
    ownedIngredient.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> removeSavedOwnedIngredient(String ingredient) async {
  final db = await configureDatabase();

  await db.delete("owned_ingredients",
      where: "ingredient = ?", whereArgs: [ingredient]);
}

Future<List<OwnedIngredient>> savedOwnedIngredients() async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps = await db.query("owned_ingredients");
  return List.generate(
    maps.length,
    (index) => OwnedIngredient.fromMap(maps[index]),
  );
}
