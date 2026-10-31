import 'package:dio/dio.dart';

import '../../data/models/refreshtokenmodel.dart';
import '../../data/repositories/loginreposites.dart';
import '../constants/apiconstants.dart';
import '../storageservices/serviceskey.dart';

class Apiinterceptor extends Interceptor {

  Apiinterceptor(this.dio)
    : refreshDio = Dio(
        BaseOptions(
          baseUrl: dio.options.baseUrl,
          connectTimeout: dio.options.connectTimeout,
          receiveTimeout: dio.options.receiveTimeout,
        ),
      );

  final Dio dio;
  final Dio refreshDio;
  Future<String>? refreshFuture;
  final Loginreposites repository = Loginreposites();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = Serviceskey.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  Future<String> refreshTokenOnce() {
    final currentRefresh = refreshFuture;
    if (currentRefresh != null) {
      return currentRefresh;
    }

    final refresh = refreshtoken();
    refreshFuture = refresh;
    return refresh.whenComplete(() {
      if (identical(refreshFuture, refresh)) {
        refreshFuture = null;
      }
    });
  }

  Future<String> refreshtoken() async {
    final refreshToken = Serviceskey.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw StateError('Refresh token is missing');
    }

    final response = await repository.refreshtoken();
    // refreshDio.post(
    //   Apiconstants.refreshtoken,
    //   data: {'refreshToken': refreshToken},
    // );
    final data = response.data;
    if (data is! Map) {
      throw const FormatException('Invalid token refresh response');
    }

    final result = Refreshtokenmodel.fromJson(Map<String, dynamic>.from(data));
    if (result.accessToken.isEmpty) {
      throw const FormatException('Refresh response has no access token');
    }

    await Serviceskey.saveLogin(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken ?? refreshToken,
      customer: Serviceskey.customer,
    );
    return result.accessToken;
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    final isRefreshRequest = request.path == Apiconstants.refreshtoken;
    if (err.response?.statusCode != 401 ||
        request.extra["retried"] == true ||
        isRefreshRequest) {
      handler.next(err);
      return;
    }

    try {
      final currentToken = Serviceskey.accessToken;
      final currentAuthorization = currentToken == null
          ? null
          : "Bearer $currentToken";
      final requestAuthorization = request.headers["Authorization"];
      final newToken =
          currentAuthorization != null &&
              currentAuthorization != requestAuthorization
          ? currentToken
          : await refreshTokenOnce();

      request
        ..extra['retried'] = true
        ..headers['Authorization'] = 'Bearer $newToken';
      final response = await dio.fetch<dynamic>(request);
      handler.resolve(response);
    } on DioException catch (refreshError) {
      handler.reject(refreshError);
    } catch (refreshError) {
      handler.reject(
        DioException(
          requestOptions: request,
          error: refreshError,
          message: 'Failed to refresh the access token',
        ),
      );
    }
  }
}
