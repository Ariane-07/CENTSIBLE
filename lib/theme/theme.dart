import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light, // Ensure the brightness is set to light
    // Set other light mode colors as needed
  ),
);

// dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark, // Ensure the brightness is set to dark
    // Set other dark mode colors as needed
  ),
);
