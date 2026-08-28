import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {

  static const titulo = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFF333333),
  );

  static const footer = TextStyle(
    fontSize: 13,
    color: AppColors.grey,
  );

  static const boton = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}