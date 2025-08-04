import 'dart:async';

import 'package:cookbook/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();
  // регистрация в getIt
  GetIt.I.registerSingleton(talker);

  // обработка ошибок интерфейса
  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  // дополнительная обработка ошибок
  runZonedGuarded(() => runApp(const MyApp()), (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
