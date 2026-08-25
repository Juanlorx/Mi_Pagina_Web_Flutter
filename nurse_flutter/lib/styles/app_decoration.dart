import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppDecoration {
  static final BoxDecoration loginContainer = BoxDecoration(
    color: AppColors.white,

    borderRadius:
        BorderRadius.circular(AppSizes.containerRadius),

    boxShadow: const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 35,
        offset: Offset(0, 15),
      ),
    ],
  );
}