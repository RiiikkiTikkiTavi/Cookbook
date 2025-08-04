import 'package:hive_flutter/hive_flutter.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 1)
class Ingredient {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int quantity;
  @HiveField(2)
  final String unit;
  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });
}
