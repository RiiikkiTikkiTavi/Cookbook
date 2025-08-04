// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cookbook/repositories/products_nutrition/models/ingredient.dart';

class Recipe {
  final int id;
  final String title;
  final String descr;
  final int? cookTime;
  final Ingredient ingredient;
  Recipe({
    required this.id,
    required this.title,
    required this.descr,
    this.cookTime,
    required this.ingredient,
  });
}
