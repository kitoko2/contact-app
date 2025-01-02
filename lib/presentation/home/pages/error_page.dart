import 'package:contact_app/core/assets.dart';
import 'package:contact_app/presentation/shared/extension.dart';
import 'package:contact_app/presentation/shared/second_button.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ErrorPage(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
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
                constraints: BoxConstraints(maxWidth: 250),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            16.verticalSpace,
            UnconstrainedBox(
              child: Container(
                constraints: BoxConstraints(maxWidth: 250),
                child: SecondButton(
                  text: "Réessayer",
                  onPressed: widget.onTap,
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
