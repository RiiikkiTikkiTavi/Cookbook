import 'package:flutter/material.dart';
import 'package:cookbook/router/router.dart';
import 'package:cookbook/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookbook',
      theme: lightTheme,
      routes: routes,
      navigatorObservers: [
        // передаем инстанс толкера
        TalkerRouteObserver(GetIt.I<Talker>()),
      ],
    );
  }
}
