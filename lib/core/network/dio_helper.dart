import 'package:contact_app/core/errors/exceptions.dart';
import 'package:contact_app/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static late Dio dio;

  DioHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      ),
    );
    if (kDebugMode) {
      dio.interceptors.addAll([
        _loggingInterceptor(),
      ]);
    }
  }

  Interceptor _loggingInterceptor() {
    return LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      error: true,
    );
  }

  Future<Response<T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Request timed out. Please check your connection.',
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message:
              'Unable to connect to the server. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['message'] ?? 'Server error occurred';

        return ServerException(
          error,
          statusCode: statusCode,
          message: message,
        );

      default:
        return UnknownException(
          message: 'An unexpected error occurred. Please try again.',
        );
    }
  }
}
