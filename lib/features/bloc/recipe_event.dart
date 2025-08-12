// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();
  @override
  List<Object?> get props => [];
}

class AddRecipe extends RecipeEvent {
  final Recipe recipe;
  const AddRecipe({
    required this.recipe,
  });
}

class UpdateRecipe extends RecipeEvent {
  final Recipe recipe;
  const UpdateRecipe({
    required this.recipe,
  });
}

class DeleteRecipe extends RecipeEvent {
  final int id;
  const DeleteRecipe({
    required this.id,
  });
}

class OpenRecipe extends RecipeEvent {
  final int id;
  const OpenRecipe({
    required this.id,
  });
}

class LoadAllRecipes extends RecipeEvent {
  final Completer? completer;
  const LoadAllRecipes({
    this.completer,
  });
  @override
  List<Object?> get props => [completer];
}
