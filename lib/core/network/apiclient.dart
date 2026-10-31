import 'package:dio/dio.dart';
import 'package:firstapipro/core/network/apiexception.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/repositories/loginreposites.dart';
import '../../routes/apppage.dart';
import '../constants/apiconstants.dart';
import '../storageservices/serviceskey.dart';
import 'apiInterceptor.dart';

class Apiclient {
  late final Dio dio;

  final List<Apiclient> apirewable = [];
  bool isRefreshing = false;

  List<RequestOptions> failedRequestsQueue = [];
  final Loginreposites repository = Loginreposites();
  Apiclient() {
    dio = Dio(
      BaseOptions(
        baseUrl: Apiconstants.baseurl,
        connectTimeout: Apiconstants.connectTimeout,
        receiveTimeout: Apiconstants.receiveTimeout,
      ),
    );

    dio.interceptors.add(Apiinterceptor(dio));

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );




    }
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return res.data;
    } on DioException catch (e) {
      if(Statuscode==401 ){
      Future<apiclient> apirewable() async{
        await repository.refreshtoken();
        Serviceskey.saveLogin(accessToken: "accessToken",
            refreshToken: "refreshToken");
      }
      if(Statuscode==404){
        Serviceskey.clear();
        Get.toNamed(Apppage.login);
      }
    }
      throw ApiException.fromDioError(e);
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final res = await dio.post(endpoint, data: data);
      return res.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<dynamic> put(String endpoint, {dynamic data}) async {
    try {
      final res = await dio.put(endpoint, data: data);
      return res.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<dynamic> delete(String endpoint, {dynamic data}) async {
    try {
      final res = await dio.delete(endpoint, data: data);
      return res.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<dynamic> upload(
    String path, {
    required String filePath,
    String fieldName = 'file',
  }) async {
    try {
      final form = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
      });
      final res = await dio.post(path, data: form);
      return res.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
