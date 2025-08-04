import 'package:cookbook/repositories/recipe_repository/models/recipe.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AbstractRecipeSource {
  Future<List<Recipe>> getAll();
  Future<Recipe?> getById(int id);
  Future<void> save(Recipe recipe);
  Future<void> delete(int id);
}

class RecipeLocalSource implements AbstractRecipeSource {
  final Box<Recipe> recipeBox;

  RecipeLocalSource(this.recipeBox);

  @override
  Future<void> delete(int id) async {
    await recipeBox.delete(id);
  }

  @override
  Future<List<Recipe>> getAll() async {
    return recipeBox.values.toList();
  }

  @override
  Future<Recipe?> getById(int id) async {
    return recipeBox.get(id);
  }

  @override
  Future<void> save(Recipe recipe) async {
    await recipeBox.put(recipe.id, recipe);
  }
}
