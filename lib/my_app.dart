import 'package:flutter/material.dart';
import 'package:cookbook/router/router.dart';
import 'package:cookbook/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookbook',
      theme: lightTheme,
      routes: routes,
    );
  }
}
