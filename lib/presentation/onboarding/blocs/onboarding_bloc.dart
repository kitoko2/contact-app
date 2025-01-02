import 'package:contact_app/domain/usecases/complete_onboarding_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class CompleteOnboardingEvent extends OnboardingEvent {}

// States
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingCompleting extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final CompleteOnboardingUseCase completeOnboardingUseCase;

  OnboardingBloc({required this.completeOnboardingUseCase})
      : super(OnboardingInitial()) {
    on<CompleteOnboardingEvent>(_onCompleteOnboarding);
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingCompleting());

    final result = await completeOnboardingUseCase();

    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(OnboardingCompleted()),
    );
  }
}
