// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cookbook/repositories/recipe_repository/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'recipe.g.dart';

@HiveType(typeId: 2)
class Recipe extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String descr;
  @HiveField(3)
  final int? cookTime;
  @HiveField(4)
  final List<Ingredient> ingredient;
  const Recipe({
    required this.id,
    required this.title,
    required this.descr,
    this.cookTime,
    required this.ingredient,
  });

  @override
  List<Object?> get props => [id, title, descr, cookTime, ingredient];
}
