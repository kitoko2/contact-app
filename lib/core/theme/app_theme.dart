import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  /// Thème clair (par défaut)
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primarySun600,
    scaffoldBackgroundColor: AppColors.neutralWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primarySun600,
      titleTextStyle: TextStyle(
        fontFamily: montserrat,
        color: AppColors.neutralWhite,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.secondaryAlbescent50,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(
        AppColors.primarySun600.withOpacity(.2),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
              color: AppColors.primarySun600); // Couleur quand sélectionné
        }
        return const TextStyle(color: Colors.grey); // Couleur par défaut
      }),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primarySun600,
      // secondary: AppColors.blueDianne600,
      surface: AppColors.neutralWhite,
      onPrimary: AppColors.neutralWhite,
      onSecondary: AppColors.neutralWhite,
      // onSurface: AppColors.neutral900,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primarySun950,
        extendedTextStyle: TextStyle(
          fontFamily: montserrat,
        )),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: const TextStyle(
        color: AppColors.primarySun950,
        fontFamily: montserrat,
        fontSize: 14,
      ),
    )),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.neutral950,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: montserrat,
      ),
      headlineMedium: TextStyle(
        color: AppColors.neutral950,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: montserrat,
      ),
      titleMedium: TextStyle(
        color: AppColors.neutral950,
        fontFamily: montserrat,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: AppColors.neutral950,
        fontFamily: montserrat,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.neutral950,
        fontFamily: montserrat,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: AppColors.neutral950,
        fontFamily: montserrat,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarySun600,
        foregroundColor: AppColors.neutralWhite,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  // / Thème sombre
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primarySun400,
    scaffoldBackgroundColor: AppColors.scaffoldDarkBg,
    dividerColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primarySun600,
      titleTextStyle: TextStyle(
        fontFamily: montserrat,
        color: AppColors.neutralWhite,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.neutral900,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(
        AppColors.primarySun400.withOpacity(.2),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
              color: AppColors.primarySun400); // Couleur quand sélectionné
        }
        return const TextStyle(
            color: AppColors.neutral400); // Couleur par défaut
      }),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primarySun400,
      // secondary: AppColors.blueDianne400,
      surface: AppColors.neutral900,
      onPrimary: AppColors.neutral950,
      onSecondary: AppColors.neutral950,
      // onSurface: AppColors.neutralWhite,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primarySun400,
      foregroundColor: AppColors.neutral950,
      extendedTextStyle: TextStyle(
        fontFamily: montserrat,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          color: AppColors.primarySun400,
          fontFamily: montserrat,
          fontSize: 14,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.neutralWhite,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: montserrat,
      ),
      headlineMedium: TextStyle(
        color: AppColors.neutralWhite,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: montserrat,
      ),
      titleMedium: TextStyle(
        color: AppColors.neutralWhite,
        fontFamily: montserrat,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: AppColors.neutralWhite,
        fontFamily: montserrat,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.neutralWhite,
        fontFamily: montserrat,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: AppColors.neutralWhite,
        fontFamily: montserrat,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarySun400,
        foregroundColor: AppColors.neutral950,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
