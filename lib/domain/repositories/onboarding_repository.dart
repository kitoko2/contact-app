import 'package:dartz/dartz.dart';
import 'package:contact_app/core/errors/failures.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, void>> completeOnboarding();
  Future<Either<Failure, bool>> isOnboardingCompleted();
}
