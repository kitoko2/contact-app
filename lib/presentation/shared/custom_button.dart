import 'package:contact_app/core/theme/app_colors.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44, // Hauteur fixe selon Figma
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32), // Radius de 32px
        gradient: const LinearGradient(
          colors: [
            AppColors.primarySun600,
            AppColors.primarySun700,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarySun950.withOpacity(.08),
            offset: const Offset(0, 1), // X: 0, Y: 1
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: isLoading ? null : onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20, // Padding horizontal 20px
          vertical: 10, // Padding vertical 10px
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: montserrat,
                ),
              ),
      ),
    );
  }
}
