import 'package:contact_app/core/theme/app_colors.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';

class SecondButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const SecondButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        border: Border.all(
          color: AppColors.primarySun600,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarySun950.withOpacity(.08),
            offset: const Offset(0, 1),
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
          horizontal: 20,
          vertical: 10,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primarySun600),
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: AppColors.primarySun600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: montserrat,
                ),
              ),
      ),
    );
  }
}
