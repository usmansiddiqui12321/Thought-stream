import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]!),
  colorScheme: ColorScheme.dark(
      background: Colors.grey[900]!,
      primary: Colors.grey[800]!,
      secondary: Colors.grey[700]!),
  textButtonTheme: TextButtonThemeData(
    style:
        TextButton.styleFrom(foregroundColor: Colors.white)),
iconTheme: const IconThemeData(color: Colors.white)
  );
