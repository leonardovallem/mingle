import 'dart:convert';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/model/dto/recipe_dto.dart';

const BASE_URI = "http://192.168.0.111:8080";
const RECIPES = "receitas";
const INGREDIENTS = "ingredientes";
const USERS = "usuarios";

Future<RecipeDTO> fetchRecipe(String _id) async {
  final response = await get(Uri.parse(join(BASE_URI, RECIPES, _id)));

  if (response.statusCode != 200) throw Exception("Fail -> GET [Recipe:$_id]");

  return RecipeDTO.fromMap(jsonDecode(response.body));
}

Future<List<RecipeDTO>> fetchAllRecipes() async {
  final response = await get(Uri.parse(join(BASE_URI, RECIPES)));

  if (response.statusCode != 200) throw Exception("Fail -> GET [Recipe:ALL]");

  List<dynamic> recipes = jsonDecode(response.body);
  List<RecipeDTO> dtos = [];
  // print(JsonDecoder().convert(response.body));
  recipes.forEach((object) {
    // dtos.add(RecipeDTO.fromMap(object));
    Map<String, dynamic> map = jsonDecode(jsonEncode(object));
    try {
      print("aaaaaaaaa ${RecipeDTO.fromMap(map)}");
    } catch(e) {
      print(e);
    }
  });

  return recipes.map((object) => RecipeDTO.fromMap(object)).toList();
}

Future<IngredientDTO> fetchIngredient(String _id) async {
  final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, _id)));

  if (response.statusCode != 200) throw Exception("Fail -> GET [Ingredient:$_id]");

  return IngredientDTO.fromMap(jsonDecode(response.body));
}