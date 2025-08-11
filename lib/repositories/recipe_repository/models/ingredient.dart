import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 1)
class Ingredient extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double quantity;
  @HiveField(2)
  final String unit;
  const Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Ingredient copyWith({String? name, double? quantity, String? unit}) {
    return Ingredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [name, quantity, unit];
}
