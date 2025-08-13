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

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipeList;
  const RecipeLoaded({
    required this.recipeList,
  });

  @override
  List<Object?> get props => [recipeList];
}

class RecipeOpened extends RecipeState {
  final Recipe recipe;

  const RecipeOpened(this.recipe);
  @override
  List<Object?> get props => [recipe];
}

class RecipeLoadingFailure extends RecipeState {
  final Object? exception;
  const RecipeLoadingFailure({this.exception});

  @override
  List<Object?> get props => [exception];
}
