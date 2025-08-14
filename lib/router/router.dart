import 'package:flutter/widgets.dart';

import '../features/recipe/recipe.dart';
import '../features/recipelist/recipe_list.dart';

final routes = {
  //'/recipe_list': (context) => const RecipeListScreen(),
  '/': (context) => const RecipeListScreen(),
  '/recipe': (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return RecipeScreen(
      recipeId: args?['id'],
      isReadOnly: args?['isReadOnly'] ?? false,
    );
  },
};
