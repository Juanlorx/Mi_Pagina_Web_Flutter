import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: double.infinity,

      height: 50,

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

          backgroundColor: AppColors.button,

          foregroundColor: Colors.white,

          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(10),

          ),

        ),

        onPressed: onPressed,

        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}