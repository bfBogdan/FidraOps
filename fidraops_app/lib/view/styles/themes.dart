import 'package:flutter/material.dart';
import 'colors.dart';
import 'styles.dart';
import 'sizes.dart';

class AppThemes {
  // ------------------------------
  // LIGHT THEME
  // ------------------------------
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    fontFamily: 'SF Pro',

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),

    scaffoldBackgroundColor: AppColors.background,

    textTheme: TextTheme(
      headlineLarge: AppStyles.headline1,
      headlineMedium: AppStyles.headlineMedium,
      headlineSmall: AppStyles.headlineSmall,
      bodyLarge: AppStyles.body1,
      labelLarge: AppStyles.button,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        textStyle: AppStyles.button,
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingSmall,
          horizontal: AppSizes.paddingDefault,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusDefault),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      filled: true,
      fillColor: AppColors.surface,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      titleTextStyle: AppStyles.headline1.copyWith(
        color: AppColors.onPrimary,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: AppColors.onPrimary),
    ),
  );

  // ------------------------------
  // DARK THEME
  // ------------------------------
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    fontFamily: 'SF Pro',

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,         // same brand color
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      background: const Color(0xFF121212), // dark background
      onBackground: Colors.white,
      surface: const Color(0xFF1E1E1E),   // dark surfaces
      onSurface: Colors.white,
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    textTheme: TextTheme(
      headlineLarge: AppStyles.headline1.copyWith(color: Colors.white),
      bodyLarge: AppStyles.body1.copyWith(color: Colors.white),
      labelLarge: AppStyles.button.copyWith(color: Colors.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        textStyle: AppStyles.button,
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingSmall,
          horizontal: AppSizes.paddingDefault,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusDefault),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      titleTextStyle: AppStyles.headline1.copyWith(
        color: Colors.white,
        fontSize: 20,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
  );
}
