import 'package:flutter/material.dart';

final defaultTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.pink,
  secondaryHeaderColor: Colors.pink,
  appBarTheme: const AppBarTheme(color: Colors.pink),
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: Colors.pink,
  ),
  chipTheme: ThemeData.dark().chipTheme.copyWith(
        selectedColor: Colors.pink,
      ),
);
