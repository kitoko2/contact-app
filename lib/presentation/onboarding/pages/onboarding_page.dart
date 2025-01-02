import 'package:contact_app/core/assets.dart';
import 'package:contact_app/core/theme/app_colors.dart';
import 'package:contact_app/presentation/home/pages/home_page.dart';
import 'package:contact_app/presentation/onboarding/blocs/onboarding_bloc.dart';
import 'package:contact_app/presentation/shared/extension.dart';
import 'package:contact_app/presentation/shared/custom_button.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeName = 'onboarding';

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          context.goNamed(HomePage.routeName);
        } else if (state is OnboardingError) {
          // Afficher un message d'erreur si nécessaire
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: FadeInImage(
                placeholder: AssetImage(Images.bg),
                image: AssetImage(Images.bg),
                width: double.infinity,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 300),
              ),
            ),
            Container(
              padding: EdgeInsets.all(appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  LottieBuilder.asset(
                    Images.hello,
                    repeat: false,
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: montserrat,
                        ),
                        children: [
                          TextSpan(
                            text: 'Akwaba sur $appName, ',
                            style: const TextStyle(
                              color: AppColors.primaryMoon700,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .description_onboarding,
                            style: const TextStyle(
                              color: AppColors.neutralWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  8.verticalSpace,
                  CustomButton(
                    width: double.infinity,
                    isLoading: false,
                    onPressed: _continue,
                    text: AppLocalizations.of(context)!.continuer,
                  ),
                  8.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _continue() {
    context.read<OnboardingBloc>().add(CompleteOnboardingEvent());
  }
}
