import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Color.fromARGB(31, 22, 22, 22),
    secondary: Color.fromARGB(255, 53, 53, 53),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 53, 53, 53),
    primary: Colors.white,
    secondary: Color.fromARGB(255, 53, 53, 53),
  ),
);
