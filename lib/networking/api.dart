import 'dart:convert';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:projects/dao/user_dao.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/model/dto/registered_ingredient.dart';

const BASE_URI = "http://192.168.0.106:8080";
const RECIPES = "receitas";
const INGREDIENTS = "ingredientes";
const REGISTERED_INGREDIENT = "ingrediente-cadastrado";
const REGISTERED_INGREDIENTS = "ingredientes-cadastrados";
const USERS = "usuarios";

class RecipeAPI {
  static Future<RecipeDTO?> fetch(String _id) async {
    final response = await get(Uri.parse(join(BASE_URI, RECIPES, _id)));

    if (response.statusCode != 200) return null;

    return RecipeDTO.fromMap(jsonDecode(response.body));
  }

  static Future<List<RecipeDTO>> fetchAll() async {
    var response = await get(Uri.parse(join(BASE_URI, RECIPES)));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(response.body);
    return recipes.map((object) => RecipeDTO.fromMap(object)).toList();
  }

  static Future<List<RecipeDTO>> fetchByName(String name) async {
    final response = await get(Uri.parse(join(BASE_URI, RECIPES, "?nome=$name")));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(response.body);
    return recipes.map((object) => RecipeDTO.fromMap(object)).toList();
  }

  static Future<List<RecipeDTO>> fetchFromIngredients() async {
    var user = await currentUsername();
    final response = await get(Uri.parse(join(BASE_URI, RECIPES, REGISTERED_INGREDIENTS, user)));
    print(response.body);

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(response.body);
    return recipes.map((object) => RecipeDTO.fromMap(object)).toList();
  }

  static Future<Response> insert(RecipeDTO recipe) async {
    return await post(
      Uri.parse(join(BASE_URI, RECIPES)),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(recipe.toMap()),
    );
  }
}

class IngredientAPI {
  static Future<IngredientDTO?> fetch(String _id) async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, _id)));

    if (response.statusCode != 200) return null;

    return IngredientDTO.fromMap(jsonDecode(response.body));
  }

  static Future<List<IngredientDTO>> fetchAll() async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS)));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(response.body);
    return recipes.map((object) => IngredientDTO.fromMap(object)).toList();
  }

  static Future<List<IngredientDTO>> fetchByName(String name) async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, "?nome=$name")));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(response.body);
    return recipes.map((object) => IngredientDTO.fromMap(object)).toList();
  }

  static Future<Response> insert(String name) async {
    return await post(
      Uri.parse(join(BASE_URI, INGREDIENTS)),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"nome": name}),
    );
  }
}

class MeasuredIngredientAPI {
  static Future<IngredientDTO?> fetch(String _id) async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, _id)));

    if (response.statusCode != 200) return null;

    return IngredientDTO.fromMap(jsonDecode(response.body));
  }

  static Future<List<IngredientDTO>> fetchAll() async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS)));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(response.body);
    return recipes.map((object) => IngredientDTO.fromMap(object)).toList();
  }

  static Future<List<IngredientDTO>> fetchByName(String name) async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, "?nome=$name")));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(response.body);
    return recipes.map((object) => IngredientDTO.fromMap(object)).toList();
  }
}

class RegisteredIngredientAPI {
  static Future<Response> insert(RegisteredIngredientDTO registeredIngredient) async {
    return await post(
      Uri.parse(join(BASE_URI, REGISTERED_INGREDIENT)),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(registeredIngredient.toMap()),
    );
  }
}
