import 'package:cookbook/features/bloc/recipe_bloc.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/recipe/recipe.dart';
import '../features/recipelist/recipe_list.dart';

final routes = {
  //'/recipe_list': (context) => const RecipeListScreen(),
  '/': (context) => BlocProvider(
        create: (context) => RecipeBloc(GetIt.I<AbstractRecipeSource>()),
        child: const RecipeListScreen(),
      ),
  '/recipe': (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return RecipeScreen(
      recipeId: args?['id'],
      isReadOnly: args?['isReadOnly'] ?? false,
    );
  },
};
