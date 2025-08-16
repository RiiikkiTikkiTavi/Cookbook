import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc(this.recipeSource) : super(RecipeInitial()) {
    on<LoadAllRecipes>((event, emit) async {
      try {
        await getAll(emit);
        event.completer?.complete();
      } catch (e, st) {
        emit(RecipeLoadingFailure(exception: e));
        event.completer?.completeError(e);
        GetIt.I<Talker>()
            .handle(e, st); // использование talker для вывода ошибки
      }
      //await getAll(emit);
      finally {
        GetIt.I<Talker>().debug('LoadAllRecipes ended');
      }
    });
    on<AddRecipe>((event, emit) async {
      final newId = const Uuid().v4();
      try {
        final recipeWithId = event.recipe.copyWith(id: newId);
        await recipeSource.save(recipeWithId);
        emit(RecipeActionSuccess());
      } catch (e, st) {
        emit(RecipeLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
      await getAll(emit);

      GetIt.I<Talker>().debug('AddRecipe ended');
    });
    on<UpdateRecipe>((event, emit) async {
      try {
        await recipeSource.save(event.recipe);
        emit(RecipeActionSuccess());
      } catch (e, st) {
        emit(RecipeLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
      await getAll(emit);
      GetIt.I<Talker>().debug('UpdateRecipe ended');
    });
    on<DeleteRecipe>((event, emit) async {
      try {
        await recipeSource.delete(event.id);
        emit(RecipeActionSuccess());
      } catch (e, st) {
        emit(RecipeLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
      await getAll(emit);
      GetIt.I<Talker>().debug('DeleteRecipe ended');
    });
    on<OpenRecipe>((event, emit) async {
      try {
        final recipe = await recipeSource.getById(event.id);
        emit(RecipeLoaded(recipe!));
      } on Exception catch (e, st) {
        emit(RecipeLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        GetIt.I<Talker>().debug('OpenRecipe ended');
      }
    });
  }
  //final recipeSource = GetIt.I<AbstractRecipeSource>();
  final AbstractRecipeSource recipeSource;

  Future<void> getAll(Emitter<RecipeState> emit) async {
//     try {
    if (state is! RecipeListLoaded) {
      emit(RecipeLoading());
    }
    final recipeList = await recipeSource.getAll();
    emit(RecipeListLoaded(recipeList: recipeList));
    //   } catch (e, st) {
    //     emit(RecipeLoadingFailure(exception: e));
    //     event.completer?.completeError(e);
    //     GetIt.I<Talker>().handle(e, st); // использование talker для вывода ошибки
    // }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
