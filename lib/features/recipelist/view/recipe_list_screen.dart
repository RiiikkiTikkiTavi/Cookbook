import 'package:cookbook/features/recipelist/widgets/widgets.dart';
import 'package:cookbook/repositories/recipe_repository/product_nutrition_rep.dart';
import 'package:flutter/material.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookbook'),
      ),
      body: ListView.separated(
          itemCount: 50,
          separatorBuilder: (context, i) => const Divider(),
          itemBuilder: (context, i) {
            const recipeName = 'recipe';
            return const RecipeTile(recipeName: recipeName);
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () {
          //ProductNutritionRepository().getNutrition(['1 egg', '100ml milk']);
        },
      ),
    );
  }
}
