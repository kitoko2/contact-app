import 'package:contact_app/core/errors/error_handler.dart';
import 'package:contact_app/domain/usecases/get_contact_use_case.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:contact_app/domain/entities/contact_entity.dart';

// Events
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

class LoadContactsEvent extends ContactEvent {
  final int? results;
  final int? page;
  final BuildContext context;

  const LoadContactsEvent({
    this.results,
    this.page,
    required this.context,
  });

  @override
  List<Object?> get props => [results, page];
}

class RefreshContactsEvent extends ContactEvent {
  final BuildContext context;
  final int? results;

  const RefreshContactsEvent({
    required this.context,
    this.results,
  });

  @override
  List<Object?> get props => [results];
}

// Status
enum ContactStatus {
  initial,
  loading,
  loaded,
  failure,
}

// State
class ContactState extends Equatable {
  final ContactStatus status;
  final List<ContactEntity> contacts;
  final String? error;
  // Indique si on a atteint la fin (dans notre cas il est a false)
  final bool hasReachedMax;
  final int currentPage;

  const ContactState({
    this.status = ContactStatus.initial,
    this.contacts = const [],
    this.error,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [
        status,
        contacts,
        error,
        hasReachedMax,
        currentPage,
      ];

  ContactState copyWith({
    ContactStatus? status,
    List<ContactEntity>? contacts,
    String? error,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return ContactState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      error: error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  bool get isLoading => status == ContactStatus.loading;
  bool get isLoaded => status == ContactStatus.loaded;
  bool get isFailure => status == ContactStatus.failure;
}

// Bloc
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final GetContactsUseCase getContactsUseCase;

  ContactBloc({required this.getContactsUseCase})
      : super(const ContactState()) {
    on<LoadContactsEvent>(_onLoadContacts);
    on<RefreshContactsEvent>(_onRefreshContacts);
  }

  Future<void> _onLoadContacts(
    LoadContactsEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ContactStatus.loading));

      final result = await getContactsUseCase(
        results: event.results,
        page: event.page,
      );

      result.fold(
        (failure) {
          final errorMessage =
              ErrorHandler.getErrorMessage(event.context, failure);
          emit(state.copyWith(
            status: ContactStatus.failure,
            error: errorMessage,
          ));
        },
        (newContacts) {
          final contacts = [...state.contacts, ...newContacts];
          emit(state.copyWith(
            status: ContactStatus.loaded,
            contacts: contacts,
            error: null,
            currentPage: event.page,
            hasReachedMax: newContacts.isEmpty,
          ));
        },
      );
    } catch (e, stackTrace) {
      debugPrint("Error $e ==== stackTrace $stackTrace");
      final errorMessage = ErrorHandler.getErrorMessage(event.context, e);
      emit(state.copyWith(
        status: ContactStatus.failure,
        error: errorMessage,
      ));
    }
  }

  Future<void> _onRefreshContacts(
    RefreshContactsEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      // Indiquer que le rafraîchissement est en cours
      emit(
        state.copyWith(
          status: ContactStatus.loading,
        ),
      );

      final result = await getContactsUseCase(
        results: event.results ?? 20,
        page: initialPage,
      );

      result.fold(
        (failure) {
          final errorMessage =
              ErrorHandler.getErrorMessage(event.context, failure);
          emit(state.copyWith(
            status: ContactStatus.failure,
            error: errorMessage,
          ));
        },
        (contacts) {
          emit(state.copyWith(
            status: ContactStatus.loaded,
            contacts: contacts,
            error: null,
            currentPage: initialPage,
            hasReachedMax: contacts.isEmpty,
          ));
        },
      );
    } catch (e, stackTrace) {
      debugPrint("Error $e ==== stackTrace $stackTrace");
      final errorMessage = ErrorHandler.getErrorMessage(event.context, e);
      emit(state.copyWith(
        status: ContactStatus.failure,
        error: errorMessage,
      ));
    }
  }
}
