class MealModel {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strCountry;
  final String strCategory;
  final String strInstructions;
  final String strSource;

  MealModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strCountry,
    required this.strCategory,
    required this.strInstructions,
    required this.strSource,
  });

  factory MealModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MealModel(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strCountry: json['strArea'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strSource: json['strSource'] ?? '',
    );
  }
}