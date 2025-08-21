import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    fontFamily: "NT Somic",
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 48,
      foregroundColor: Colors.white,
      surfaceTintColor: AppColors.white,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.defaultDark,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.dividerColor,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primaryButtonColor,
      inactiveTrackColor: AppColors.buttonPrimaryLight,
      thumbColor: AppColors.primaryButtonColor,
      trackHeight: 8,
      overlayColor: Colors.transparent,
      rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 12, pressedElevation: 0, elevation: 0),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.tabSelected,
      unselectedLabelColor: AppColors.tabUnselected,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColors.tabSelected,
      dividerColor: AppColors.borderColor,
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        // Use the default focused overlay color
        return states.contains(WidgetState.focused) ? null : Colors.transparent;
      }),
      indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.tabSelected,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.circular(1)),
      labelStyle: headlineMedium,
      unselectedLabelStyle: headlineMedium,
    ),
    textTheme: const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    ),
  );

  static const displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.defaultDark,
  );
  static const displayMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.defaultDark,
  );
  static const displaySmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.defaultDark,
  );
  static const headlineLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.defaultDark,
  );
  static const headlineMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.defaultDark,
  );
  static const headlineSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.defaultDark,
  );
  static const titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.defaultDark,
  );
  static const titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.defaultDark,
  );
  static const titleSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.defaultDark,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.defaultDark,
  );
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.defaultDark,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.defaultDark,
  );
  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.defaultDark,
  );
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.defaultDark,
  );
  static const labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.defaultDark,
  );
}
