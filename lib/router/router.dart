import '../features/recipe/recipe.dart';
import '../features/recipelist/recipe_list.dart';

final routes = {
  //'/recipe_list': (context) => const RecipeListScreen(),
  '/': (context) => const RecipeListScreen(),
  '/recipe': (context) => const RecipeScreen(),
};
