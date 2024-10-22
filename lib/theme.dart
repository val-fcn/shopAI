import "package:flutter/material.dart";

class AppTheme {
  static const Color backgroundColor = Color(0xFFABD1C6);
  static const Color headlineColor = Color(0xFF004643);
  static const Color paragraphColor = Color(0xFF004643);
  static const Color buttonColor = Color(0xFFF9BC60);
  static const Color buttonTextColor = Color(0xFF001E1D);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: headlineColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: paragraphColor,
        fontSize: 16,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: buttonTextColor,
        backgroundColor: buttonColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      titleTextStyle: TextStyle(
        color: headlineColor,
        fontSize: 20,
      ),
    ),
  );
}
