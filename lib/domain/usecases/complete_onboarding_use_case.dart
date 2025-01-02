import 'package:dartz/dartz.dart';
import 'package:contact_app/core/errors/failures.dart';
import 'package:contact_app/domain/repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository repository;

  CompleteOnboardingUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.completeOnboarding();
  }
}
