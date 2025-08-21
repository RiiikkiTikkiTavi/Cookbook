import 'package:cookbook/features/bloc/recipe_bloc.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    //final _recipeBloc = RecipeBloc(GetIt.I<AbstractRecipeSource>());
    final recipeBloc = context.read<RecipeBloc>();
    final theme = Theme.of(context);
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            recipe.title,
            style: theme.textTheme.bodyMedium,
          ),
          subtitle: Text(
            "30 мин",
            style: theme.textTheme.labelSmall,
          ),
          /* trailing: SvgPicture.asset(
            AppImages.cook,
            height: 25,
            width: 25,
          ),*/
          onTap: () async {
            final shouldRefresh = await Navigator.of(context).pushNamed(
              '/recipe',
              arguments: {
                'id': recipe.id,
                'isReadOnly': true,
              },
            );
            if (shouldRefresh == true) {
              recipeBloc.add(const LoadAllRecipes());
            }
          },
        );
      },
    );
  }
}
