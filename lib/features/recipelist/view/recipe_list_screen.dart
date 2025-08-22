import 'dart:async';

import 'package:cookbook/features/bloc/recipe_bloc.dart';
import 'package:cookbook/features/recipelist/widgets/widgets.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  Recipe? recipe;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipeBloc = context.read<RecipeBloc>();
      recipeBloc.add(const LoadAllRecipes());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeBloc = context.read<RecipeBloc>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookbook'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(talker: GetIt.I<Talker>()),
                ),
              );
            },
            icon: const Icon(Icons.document_scanner_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer =
              Completer(); // сообщает, что асинхронный метод завершился
          recipeBloc.add(LoadAllRecipes(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<RecipeBloc, RecipeState>(
          bloc: recipeBloc,
          builder: (context, state) {
            if (state is RecipeListLoaded) {
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
        onPressed: () async {
          //Navigator.of(context).pushNamed('/recipe');
          final shouldRefresh = await Navigator.of(context).pushNamed(
            '/recipe',
          );
          if (shouldRefresh == true) {
            recipeBloc.add(const LoadAllRecipes());
          }
          //ProductNutritionRepository().getNutrition(['1 egg', '100ml milk']);
        },
      ),
    );
  }
}
