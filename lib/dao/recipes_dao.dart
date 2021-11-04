import 'package:projects/config/database.dart';
import 'package:projects/model/recipe.dart';
import 'package:sqflite/sqflite.dart';

Future<void> saveRecipe(Recipe recipe) async {
  final db = await configureDatabase();

  await db.insert(
    "recipes",
    recipe.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> removeSavedRecipe(String _id) async {
  final db = await configureDatabase();

  await db.delete(
    "recipes",
    where : "_id = ?",
    whereArgs: [_id]
  );
}

Future<List<Recipe>> savedRecipes() async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps = await db.query("recipes");
  return List.generate(maps.length, (index) => Recipe.fromMap(maps[index]));
}
