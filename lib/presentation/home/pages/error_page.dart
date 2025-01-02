import 'package:contact_app/core/assets.dart';
import 'package:contact_app/presentation/shared/extension.dart';
import 'package:contact_app/presentation/shared/second_button.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorPage extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ErrorPage({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(appPadding),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            LottieBuilder.asset(
              Images.error,
              height: 100,
            ),
            UnconstrainedBox(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            16.verticalSpace,
            UnconstrainedBox(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 250),
                child: SecondButton(
                  text: AppLocalizations.of(context)!.try_again,
                  onPressed: onTap,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
