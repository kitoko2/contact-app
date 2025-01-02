import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String keyOnboardingCompleted = 'onboarding_completed';

  OnboardingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> isOnboardingCompleted() async {
    return sharedPreferences.getBool(keyOnboardingCompleted) ?? false;
  }

  @override
  Future<void> setOnboardingCompleted() async {
    await sharedPreferences.setBool(keyOnboardingCompleted, true);
  }
}
