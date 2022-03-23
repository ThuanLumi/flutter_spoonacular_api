import 'dart:io';
import 'dart:convert';
import 'package:flutter_template_spoonacular_api/models/meal_plan_model.dart';
import 'package:flutter_template_spoonacular_api/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_template_spoonacular_api/utilities/key.dart';

class APIService {
  APIService._instance();

  static final APIService instance = APIService._instance();

  final String _baseUrl = 'api.spoonacular.com';

  //Generate Meal Plan
  Future<MealPlan> generateMealPlan(
      {required int targetCalories, required String diet}) async {
    if (diet == 'None') diet = '';

    Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(_baseUrl, '/mealplanner/generate', parameters);
    // print(uri);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    try {
      var response = await http.get(uri, headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      // print(data);

      MealPlan mealPlan = MealPlan.fromMap(data);

      return mealPlan;
    } catch (err) {
      throw err.toString();
    }
  }

  //Recipe Info
  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(_baseUrl, '/recipes/$id/information', parameters);
    print(uri);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    try {
      var response = await http.get(uri, headers: headers);

      Map<String, dynamic> data = json.decode(response.body);

      Recipe recipe = Recipe.fromMap(data);

      return recipe;
    } catch (err) {
      throw err.toString();
    }
  }
}
