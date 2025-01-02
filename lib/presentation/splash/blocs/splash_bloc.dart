import 'package:contact_app/data/datasources/local/onboarding_local_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class CheckOnboardingStatusEvent extends SplashEvent {}

// States
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class NavigateToOnboarding extends SplashState {}

class NavigateToHome extends SplashState {}

// Bloc
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final OnboardingLocalDataSource onboardingLocalDataSource;

  SplashBloc({required this.onboardingLocalDataSource})
      : super(SplashInitial()) {
    on<CheckOnboardingStatusEvent>(_onCheckOnboardingStatus);
  }

  Future<void> _onCheckOnboardingStatus(
    CheckOnboardingStatusEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final isOnboardingCompleted =
        await onboardingLocalDataSource.isOnboardingCompleted();

    if (isOnboardingCompleted) {
      emit(NavigateToHome());
    } else {
      emit(NavigateToOnboarding());
    }
  }
}
