import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: false,
  primarySwatch: Colors.green,
  //scaffoldBackgroundColor: Colors.white54,
  dividerColor: Colors.black26,
  listTileTheme: const ListTileThemeData(iconColor: Colors.amber),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w200,
      fontSize: 14,
    ),
  ),
);
