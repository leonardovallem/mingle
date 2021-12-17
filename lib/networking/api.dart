import 'dart:convert';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:projects/dao/user_dao.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/model/dto/registered_ingredient.dart';
import 'package:projects/model/dto/used_ingredient_dto.dart';

const BASE_URI = "https://mingle-api.herokuapp.com";
const RECIPES = "receitas";
const INGREDIENTS = "ingredientes";
const REGISTERED_INGREDIENT = "ingrediente-cadastrado";
const REGISTERED_INGREDIENTS = "ingredientes-cadastrados";
const USERS = "usuarios";

class RecipeAPI {
  static Future<RecipeDTO?> fetch(String _id) async {
    final response = await get(Uri.parse(join(BASE_URI, RECIPES, _id)));

    if (response.statusCode != 200) return null;

    return RecipeDTO.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  static Future<List<RecipeDTO>> fetchAll() async {
    var response = await get(Uri.parse(join(BASE_URI, RECIPES)));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(utf8.decode(response.bodyBytes));
    return distinct(recipes);
  }

  static Future<List<RecipeDTO>> fetchByName(String name) async {
    final response = await get(Uri.parse(join(BASE_URI, RECIPES, "?nome=$name")));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(utf8.decode(response.bodyBytes));
    return distinct(recipes);
  }

  static Future<List<RecipeDTO>> fetchFromIngredients(List<UsedIngredientDTO>? ingredients) async {
    var user = await currentUsername();
    var response = ingredients == null
        ? await get(Uri.parse(join(BASE_URI, RECIPES, REGISTERED_INGREDIENTS, user)))
        : await get(Uri.parse(join(BASE_URI, RECIPES)),
            headers: {"Content-Type": "application/json"}, body: jsonEncode(ingredients.map((e) => e.toMap()).toList()));

    if (response.statusCode != 200) return [];

    List<dynamic> recipes = jsonDecode(utf8.decode(response.bodyBytes));
    return distinct(recipes);
  }

  static Future<Response> insert(RecipeDTO recipe) async {
    return await post(
      Uri.parse(join(BASE_URI, RECIPES)),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(recipe.toMap()),
    );
  }

  static List<RecipeDTO> distinct(List<dynamic> recipes) {
    var temp = {};
    recipes.map((object) => RecipeDTO.fromMap(object)).forEach((object) {
      if (!temp.containsKey(object.name)) temp.addAll({object.name: object});
    });
    List<RecipeDTO> list = [];
    temp.forEach((key, value) => list.add(value));
    return list;
  }
}

class IngredientAPI {
  static Future<IngredientDTO?> fetch(String _id) async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, _id)));

    if (response.statusCode != 200) return null;

    return IngredientDTO.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  static Future<List<IngredientDTO>> fetchAll() async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS)));

    if (response.statusCode != 200) return [];

    List<dynamic> ingredients = jsonDecode(utf8.decode(response.bodyBytes));
    return ingredients.map((object) => IngredientDTO.fromMap(object)).toList();
  }

  static Future<List<IngredientDTO>> fetchByName(String name) async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, "?nome=$name")));

    if (response.statusCode != 200) return [];

    List<dynamic> ingredients = jsonDecode(utf8.decode(response.bodyBytes));
    return ingredients.map((object) => IngredientDTO.fromMap(object)).toList();
  }

  static Future<Response> insert(String name) async {
    return await post(
      Uri.parse(join(BASE_URI, INGREDIENTS)),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"nome": name}),
    );
  }

  static Future<List<IngredientDTO>> fetchAllNotFromCurrentUser() async {
    var user = await currentUsername();
    final response = await get(Uri.parse(join(BASE_URI, REGISTERED_INGREDIENT, "except", user)));

    if (response.statusCode != 200) return [];

    List<dynamic> ingredients = jsonDecode(response.body);
    return ingredients.map((object) => UsedIngredientDTO.fromMap(object).ingredient).toList();
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

    List<dynamic> ingredients = jsonDecode(response.body);
    return ingredients.map((object) => IngredientDTO.fromMap(object)).toList();
  }

  static Future<List<IngredientDTO>> fetchByName(String name) async {
    final response = await get(Uri.parse(join(BASE_URI, INGREDIENTS, "?nome=$name")));

    if (response.statusCode != 200) return [];

    List<dynamic> ingredients = jsonDecode(response.body);
    return ingredients.map((object) => IngredientDTO.fromMap(object)).toList();
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

  static Future<List<IngredientDTO>> fetchFromCurrentUser() async {
    var user = await currentUsername();
    final response = await get(Uri.parse(join(BASE_URI, REGISTERED_INGREDIENT, user)));

    if (response.statusCode != 200) return [];

    List<dynamic> ingredients = jsonDecode(response.body);
    return ingredients.map((object) => UsedIngredientDTO.fromMap(object).ingredient).toList();
  }
}
