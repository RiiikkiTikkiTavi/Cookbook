import 'package:bloc/bloc.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial()) {
    final recipeBox = GetIt.I.get<Box<Recipe>>();
    on<RecipeEvent>((event, emit) {});
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
