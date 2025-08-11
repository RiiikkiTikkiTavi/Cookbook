import 'dart:async';

import 'package:cookbook/features/bloc/recipe_bloc.dart';
import 'package:cookbook/features/recipelist/widgets/widgets.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  Recipe? recipe;
  final _recipeBloc = RecipeBloc(GetIt.I<AbstractRecipeSource>());

  @override
  void initState() {
    _recipeBloc.add(LoadAllRecipes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookbook'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer =
              Completer(); // сообщает, что асинхронный метод завершился
          _recipeBloc.add(LoadAllRecipes(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<RecipeBloc, RecipeState>(
          bloc: _recipeBloc,
          builder: (context, state) {
            if (state is RecipeLoaded) {
              if (state.recipeList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Рецептов пока нет',
                        style: theme.textTheme.headlineMedium,
                      )
                    ],
                  ),
                );
              } else {
                return ListView.separated(
                    itemCount: state.recipeList.length,
                    separatorBuilder: (context, i) => const Divider(),
                    itemBuilder: (context, i) {
                      final recipe = state.recipeList[i];
                      return RecipeTile(recipe: recipe);
                    });
              }
            }
            if (state is RecipeLoadingFailure) {
              return const ErrorWidget();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/recipe');
          //ProductNutritionRepository().getNutrition(['1 egg', '100ml milk']);
        },
      ),
    );
  }
}
