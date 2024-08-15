import 'package:flutter/material.dart';

class AppTheme {
  // 主要顏色
  static const Color prussianBlue = Color(0xFF003153);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF333333);

  static final ThemeData themeData = ThemeData(
    primaryColor: prussianBlue,
    scaffoldBackgroundColor: lightGrey,
    appBarTheme: AppBarTheme(
      backgroundColor: white,
      foregroundColor: prussianBlue,
      elevation: 0,
      iconTheme: IconThemeData(color: prussianBlue),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: prussianBlue,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: prussianBlue,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: prussianBlue, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: darkGrey, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: darkGrey),
      bodyMedium: TextStyle(color: darkGrey),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: darkGrey.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: prussianBlue, width: 2),
      ),
      labelStyle: TextStyle(color: darkGrey),
      focusColor: prussianBlue,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: prussianBlue,
      inactiveTrackColor: lightGrey,
      thumbColor: prussianBlue,
      overlayColor: prussianBlue.withOpacity(0.2),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: darkGrey,
      contentTextStyle: TextStyle(color: white),
    ),
    cardTheme: CardTheme(
      color: white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: darkGrey.withOpacity(0.1),
      thickness: 1,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: prussianBlue,
      foregroundColor: white,
    ),
    colorScheme: ColorScheme.light(
      primary: prussianBlue,
      secondary: prussianBlue.withOpacity(0.7),
      surface: white,
      background: lightGrey,
      onPrimary: white,
      onSecondary: white,
      onSurface: darkGrey,
      onBackground: darkGrey,
    ),
  );
}