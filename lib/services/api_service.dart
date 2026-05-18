import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';

class ApiService {
  static const String baseUrl =
      'https://www.themealdb.com/api/json/v1/1';

  // ================================
  // GET LIST MEALS BY CATEGORY
  // ================================
  static Future<List<MealModel>> fetchMeals(
    String category,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/filter.php?c=$category',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List meals = data['meals'];

      return meals
          .map(
            (e) => MealModel.fromJson(e),
          )
          .toList();
    } else {
      throw Exception(
        'Gagal mengambil data makanan',
      );
    }
  }

  //mendapatkan dari id yang penting 
  static Future<MealModel>
      fetchMealDetail(
    String id,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/lookup.php?i=$id',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return MealModel.fromJson(
        data['meals'][0],
      );
    } else {
      throw Exception(
        'Gagal mengambil detail makanan',
      );
    }
  }
}