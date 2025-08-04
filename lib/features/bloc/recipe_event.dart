part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class AddRecipe extends RecipeEvent {}

class UpdateRecipe extends RecipeEvent {}

class DeleteRecipe extends RecipeEvent {}

class OpenRecipe extends RecipeEvent {}

class LoadAllRecipes extends RecipeEvent {}
