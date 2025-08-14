import 'package:cookbook/repositories/recipe_repository/models/models.dart';
import 'package:cookbook/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        recipe.title,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        "30 мин",
        style: theme.textTheme.labelSmall,
      ),
      trailing: SvgPicture.asset(
        AppImages.cook,
        height: 25,
        width: 25,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/recipe',
          arguments: {
            'id': recipe.id,
            'isReadOnly': true,
          },
        );
      },
    );
  }
}
