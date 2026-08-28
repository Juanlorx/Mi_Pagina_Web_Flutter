import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizes.radiusInput),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizes.radiusInput),
        borderSide: const BorderSide(
          color: AppColors.secondary,
          width: 2,
        ),
      ),
    ),
  );
}