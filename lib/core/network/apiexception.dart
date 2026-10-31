import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    print('Dio error: ${error.message}');
    print('Error details: ${error.error}');
    print('Request URL: ${error.requestOptions.uri}');
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:

        return ApiException(
          message: 'Connection timed out. Please check your internet connection.',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response?.statusCode, error.response?.data);
      case DioExceptionType.cancel:
        return ApiException(message: 'Request was cancelled.');
      case DioExceptionType.connectionError:
        return ApiException(message: 'No internet connection. Please verify your network.');
      default:
        return ApiException(message: 'An unexpected error occurred. Please try again.');
    }
  }

  static ApiException _handleResponseError(int? statusCode, dynamic data) {
    String extractErrorMessage() {
      if (data is Map<String, dynamic>) {
        return data['message']?.toString() ??
            data['error']?.toString() ??
            'Something went wrong.';
      }
      return 'Server error occurred.';
    }

    final message = extractErrorMessage();

    switch (statusCode) {
      case 400:
        return ApiException(message: message, statusCode: 400);
      case 401:
        return ApiException(message: 'Session expired or invalid credentials.', statusCode: 401);
      case 403:
        return ApiException(message: message.isNotEmpty ? message : 'Access forbidden or account incomplete.', statusCode: 403);
      case 404:
        return ApiException(message: message.isNotEmpty ? message : 'Resource not found.', statusCode: 404);
      case 422:
        return ApiException(message: message.isNotEmpty ? message : 'Validation failed. Check your data.', statusCode: 422);
      case 500:
      case 502:
      case 503:
        return ApiException(message: 'Server issue. Please try again later.', statusCode: statusCode);
      default:
        return ApiException(message: message, statusCode: statusCode);
    }
  }

  @override
  String toString() => message;
}
