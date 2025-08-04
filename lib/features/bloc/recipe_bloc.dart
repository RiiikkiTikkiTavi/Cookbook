import 'package:bloc/bloc.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial()) {
    on<LoadAllRecipes>((event, emit) async {
      await getAll(emit);
    });
    on<AddRecipe>((event, emit) async {});
    on<UpdateRecipe>((event, emit) async {});
    on<DeleteRecipe>((event, emit) async {});
    on<OpenRecipe>((event, emit) async {});
  }

  Future<void> getAll(Emitter<RecipeState> emit) async {
    try {
      if (state is! RecipeLoaded) {
        emit(RecipeLoading());
      }
      final recipeList = await GetIt.I<AbstractRecipeSource>().getAll();
      emit(RecipeLoaded(recipeList: recipeList));
    } catch (e, st) {
      emit(RecipeLoadingFailure(exception: e));
      GetIt.I<Talker>().handle(e, st); // использование talker для вывода ошибки
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
