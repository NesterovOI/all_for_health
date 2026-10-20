import 'package:flutter/material.dart';
import 'theme.dart';

abstract class AppTheme {
  // --- СВІТЛА ТЕМА ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.lightSurface,
        error: AppColors.error,
      ),
      // Налаштування текстів за замовчуванням
      textTheme: const TextTheme(
        // Для назви заголовки екранів
        titleMedium: TextStyle(
          fontSize: AppDimensions.fontTitle, //Заголовки шрифт 22
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSubheading,
          color: AppColors.lightTextPrimary,
          height: AppDimensions.spaceXXXS,
        ),
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontBody,
          color: AppColors.lightTextSecondary,
          height: AppDimensions.spaceXXXS,
        ),
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontCaption,
          color: AppColors.lightTextPrimary,
          height: AppDimensions.spaceXXXS,
        ),
      ),
      //Налаштування віджета TextFromField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.primary,
        labelStyle: const TextStyle(color: AppColors.lightTextPrimary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceXXS,
          vertical: AppDimensions.spaceXXS,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.success),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppDimensions.spaceXXXS,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimensions.spaceXXXS,
          ),
        ),
      ),
      //Колір курсора віджета TextFromField
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
      ),
      //Налаштування віджета TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightTextPrimary,
          backgroundColor: AppColors.primary,
          textStyle: TextStyle(
            fontSize: AppDimensions.fontBody,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      //Нижня навігаційна панель
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColors.primary,
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontBody,
              color: AppColors.lightTextPrimary,
            );
          } else {
            return const TextStyle(
              fontSize: AppDimensions.fontCaption,
              color: AppColors.lightTextSecondary,
            );
          }
        }),
      ),
    );
  }

  // --- ТЕМНА ТЕМА ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.darkSurface,
        error: AppColors.error,
      ),
      // Налаштування текстів за замовчуванням
      textTheme: const TextTheme(
        // Для назви заголовки екранів
        titleMedium: TextStyle(
          fontSize: AppDimensions.fontTitle, //Заголовки шрифт 22
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSubheading,
          color: AppColors.darkTextPrimary,
          height: AppDimensions.spaceXXXS,
        ),
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontBody,
          color: AppColors.darkTextSecondary,
          height: AppDimensions.spaceXXXS,
        ),
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontCaption,
          color: AppColors.darkTextPrimary,
          height: AppDimensions.spaceXXXS,
        ),
      ),
      //Налаштування віджета TextFromField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceSecondary,
        labelStyle: const TextStyle(color: AppColors.darkTextPrimary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceXXS,
          vertical: AppDimensions.spaceXXS,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.darkSurfaceSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: AppColors.darkTextSecondary,
            width: AppDimensions.spaceXXXS,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimensions.spaceXXXS,
          ),
        ),
      ),
      //Колір курсора віджета TextFromField
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.darkTextPrimary,
      ),
      //Налаштування віджета TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.darkTextPrimary,
          backgroundColor: AppColors.darkSurface,
          textStyle: TextStyle(
            fontSize: AppDimensions.fontBody,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      //Нижня навігаційна панель
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColors.darkSurfaceSecondary,
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontBody,
              color: AppColors.darkTextPrimary,
            );
          } else {
            return const TextStyle(
              fontSize: AppDimensions.fontCaption,
              color: AppColors.darkTextSecondary,
            );
          }
        }),
      ),
    );
  }
}
