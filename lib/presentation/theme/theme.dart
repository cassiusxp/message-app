import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 224, 224, 224),
    primary: Color.fromARGB(255, 43, 42, 42),
    secondary: Color.fromARGB(255, 255, 255, 255),
    inversePrimary: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 53, 53, 53),
    primary: Colors.white,
    secondary: Color.fromARGB(255, 53, 53, 53),
    inversePrimary: Colors.white,
  ),
);
