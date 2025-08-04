// ignore_for_file: public_member_api_docs, sort_constructors_first
class Nutrition {
  final String ingr;
  final double weight;
  final double kcal;
  final double fat;
  final double carb;
  final double protein;
  const Nutrition({
    required this.ingr,
    required this.weight,
    required this.kcal,
    required this.fat,
    required this.carb,
    required this.protein,
  });
  @override
  String toString() {
    return 'Ingredient: $ingr, Weight: ${weight.toStringAsFixed(2)}g, '
        'Kcal: ${kcal.toStringAsFixed(1)}kcal, Fat: ${fat.toStringAsFixed(1)}g, '
        'Carbs: ${carb.toStringAsFixed(1)}g, Protein: ${protein.toStringAsFixed(1)}g';
  }
}
