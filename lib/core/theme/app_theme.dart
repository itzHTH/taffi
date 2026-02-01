import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

/// Application theme configuration
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: "BalooBhaijaan2",
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.light),
      scaffoldBackgroundColor: AppColors.background,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.error),
        ),

        filled: true,
        fillColor: AppColors.surface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),

      searchViewTheme: SearchViewThemeData(backgroundColor: Colors.white),

      textTheme: TextTheme(
        labelSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primary),

        labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),

        displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.primary,
        ),

        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primary.withValues(alpha: .73),
        ),

        bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFADA4A5)),

        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.primary),

        displayMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white.withAlpha(190),
        ),

        headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),

        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textHint,
        ),
      ),

      checkboxTheme: CheckboxThemeData(shape: CircleBorder()),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    );
  }
}
