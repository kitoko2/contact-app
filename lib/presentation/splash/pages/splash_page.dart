import 'package:contact_app/core/assets.dart';
import 'package:contact_app/core/theme/app_colors.dart';
import 'package:contact_app/presentation/home/pages/home_page.dart';
import 'package:contact_app/presentation/onboarding/pages/onboarding_page.dart';
import 'package:contact_app/presentation/shared/extension.dart';
import 'package:contact_app/presentation/splash/blocs/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    debugPrint("============precacheImage=========");
    await precacheImage(AssetImage(Images.bg), context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is NavigateToOnboarding) {
          context.goNamed(OnboardingPage.routeName);
        } else if (state is NavigateToHome) {
          context.goNamed(HomePage.routeName);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primarySun700,
                AppColors.primarySun600,
                AppColors.primarySun400,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.contact_phone,
                size: 100,
                color: Colors.white,
              ),
              24.verticalSpace,
              const Text(
                'Contacts App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              48.verticalSpace,
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
