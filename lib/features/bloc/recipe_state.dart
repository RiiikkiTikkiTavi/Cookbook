// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();
}

class RecipeInitial extends RecipeState {
  @override
  List<Object?> get props => [];
}

class RecipeLoading extends RecipeState {
  @override
  List<Object?> get props => [];
}

class RecipeListLoaded extends RecipeState {
  final List<Recipe> recipeList;
  const RecipeListLoaded({
    required this.recipeList,
  });

  @override
  List<Object?> get props => [recipeList];
}

class RecipeLoaded extends RecipeState {
  final Recipe recipe;

  const RecipeLoaded(this.recipe);
  @override
  List<Object?> get props => [recipe];
}

class RecipeActionSuccess extends RecipeState {
  @override
  List<Object?> get props => [];
}

class RecipeLoadingFailure extends RecipeState {
  final Object? exception;
  const RecipeLoadingFailure({this.exception});

  @override
  List<Object?> get props => [exception];
}
