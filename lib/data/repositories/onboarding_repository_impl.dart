import 'package:dartz/dartz.dart';
import 'package:contact_app/core/errors/failures.dart';
import 'package:contact_app/data/datasources/local/onboarding_local_data_source.dart';
import 'package:contact_app/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> completeOnboarding() async {
    try {
      await localDataSource.setOnboardingCompleted();
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure(message: 'Failed to complete onboarding'));
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      final isCompleted = await localDataSource.isOnboardingCompleted();
      return Right(isCompleted);
    } catch (e) {
      return const Left(
          CacheFailure(message: 'Failed to check onboarding status'));
    }
  }
}
