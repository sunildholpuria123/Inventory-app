import 'package:flutter/material.dart';

import 'app_colors.dart';

import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light =
  ThemeData(
    useMaterial3: true,

    colorScheme:
    ColorScheme.fromSeed(
      seedColor:
      AppColors.primary,
      brightness:
      Brightness.light,
    ),

    scaffoldBackgroundColor:
    AppColors.background,

    cardTheme:
    CardThemeData(
      elevation: 0,
      color: AppColors.card,
      shape:
      RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(
          AppRadius.lg,
        ),
      ),
    ),

    inputDecorationTheme:
    InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      border:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(
          AppRadius.md,
        ),
      ),

      enabledBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(
          AppRadius.md,
        ),
        borderSide:
        const BorderSide(
          color:
          AppColors.border,
        ),
      ),
    ),

    elevatedButtonTheme:
    ElevatedButtonThemeData(
      style:
      ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
            14,
          ),
        ),
      ),
    ),
  );

  static ThemeData dark =
  ThemeData(
    useMaterial3: true,

    brightness:
    Brightness.dark,

    scaffoldBackgroundColor:
    AppColors.darkBackground,

    cardTheme:
    CardThemeData(
      elevation: 0,
      color:
      AppColors.darkCard,
      shape:
      RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(
          AppRadius.lg,
        ),
      ),
    ),
  );
}