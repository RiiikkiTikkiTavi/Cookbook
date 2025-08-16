import 'dart:async';
import 'package:cookbook/my_app.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final talker = TalkerFlutter.init();
    // регистрация talker в getIt
    GetIt.I.registerSingleton(talker);

    const boxName = 'recipe_db';
    // инициализация Hive
    await Hive.initFlutter();
    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(IngredientAdapter());

    final recipeBox = await Hive.openBox<Recipe>(boxName);
    GetIt.I.registerSingleton<Box<Recipe>>(recipeBox);

    // регистрация LazySingleton по типу AbstractCoinsRepository с реализацией CryproCoinsRepository
    GetIt.I.registerLazySingleton<AbstractRecipeSource>(
      () => RecipeLocalSource(recipeBox),
    );

    // обработка ошибок интерфейса
    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

    // дополнительная обработка ошибок
    runApp(const MyApp());
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
