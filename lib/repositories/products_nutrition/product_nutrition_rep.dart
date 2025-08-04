import 'package:cookbook/repositories/products_nutrition/models/nutrition.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductNutritionRepository {
  final dio = Dio();

  // экземпляр dio - клиент для взаимодействия с сетью
  Future<List<Nutrition>> getNutrition(List<String> ingredients) async {
    final appId = 'aa353eb7';
    final appKey = 'c89c39a09130159bb704b31afc5f87ba';
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.edamam.com/api/nutrition-details',
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    // try {
    final response = await dio.post(
      '',
      queryParameters: {
        'app_id': appId,
        'app_key': appKey,
      },
      data: {
        "title": "Custom Recipe",
        "ingr": ingredients,
      },
    );

    //debugPrint('Response data: ${response.data}');

    // полученный response приводится к мапе
    final data = response.data as Map<String, dynamic>;
    // из мапы по ключу ingredients извлекается значения в виде списка
    final ingred = data['ingredients'] as List<dynamic>;

    final nutritionList = parseNutrition(ingred);
    for (final nutrition in nutritionList) {
      debugPrint(nutrition.toString());
    }
    return nutritionList;

    //return response.data;
    // } catch (e) {
    //   debugPrint('Error: $e');
    // }
  }
}

// метод для парсинга сложного json
List<Nutrition> parseNutrition(List<dynamic> ingredients) {
  List<Nutrition> result = [];

  // вспомогательный стрелочный метод
  // принимает ключ - параметр продукта
  // ищет в мапе по ключу значение 'quantity' и преобразовывает в double
  // если значение null возвращает 0.0
  double getQuantity(Map<String, dynamic>? n, String key) =>
      (n?[key]?['quantity'] as num?)?.toDouble() ?? 0.0;

  for (var ing in ingredients) {
    final parsedList = ing['parsed'] as List<dynamic>? ??
        []; // берем по тегу parsed инфу о продуктах

    for (var parsed in parsedList) {
      final nutrients = parsed['nutrients'] as Map<String, dynamic>? ??
          {}; // инфо о пищевой ценности
      final name = parsed['food'] as String;
      final weight = (parsed['weight'] as num?)?.toDouble() ?? 0.0;
      final nutrition = Nutrition(
          ingr: name,
          weight: weight,
          kcal: getQuantity(nutrients, 'ENERC_KCAL'),
          fat: getQuantity(nutrients, 'FAT'),
          carb: getQuantity(nutrients, 'CHOCDF'),
          protein: getQuantity(nutrients, 'PROCNT'));
      result.add(nutrition);
    }
  }
  return result;
}
