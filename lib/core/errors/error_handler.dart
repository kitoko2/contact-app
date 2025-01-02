import 'package:contact_app/core/errors/exceptions.dart';
import 'package:contact_app/core/errors/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Helper class to handle errors and return localized error messages
class ErrorHandler {
  /// Returns a localized error message based on the error type
  static String getErrorMessage(BuildContext context, Object error) {
    final localizations = AppLocalizations.of(context)!;

    if (error is Failure) {
      return _getFailureMessage(localizations, error);
    } else if (error is Exception) {
      return _getExceptionMessage(localizations, error);
    }
    debugPrint("_getFailureMessage==========");

    // Default error message for unknown errors
    return "Erreur";
  }

  static String _getFailureMessage(
      AppLocalizations localizations, Failure failure) {
    if (failure is ServerFailure) {
      return localizations.server_error;
    } else if (failure is NetworkFailure) {
      return localizations.network_error;
    } else if (failure is TimeoutFailure) {
      return localizations.timeout_error;
    } else if (failure is CacheFailure) {
      return localizations.cache_error;
    }
    return localizations.unknown_error;
  }

  static String _getExceptionMessage(
      AppLocalizations localizations, Exception exception) {
    if (exception is ServerException) {
      return localizations.server_error;
    } else if (exception is NetworkException) {
      return localizations.network_error;
    } else if (exception is TimeoutException) {
      return localizations.timeout_error;
    }
    return localizations.unknown_error;
  }
}
