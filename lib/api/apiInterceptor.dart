// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, unnecessary_null_comparison, unnecessary_overrides, unused_local_variable, avoid_print, unused_field

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart' as gets;

class DioLoggingInterceptors extends Interceptor {
  final Dio _dio;
  // final GetXSession _sesProv = gets.Get.find<GetXSession>();
  DioLoggingInterceptors(this._dio);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // debugPrint(options.data.toString());
    if (options.queryParameters != null) {
      // debugPrint("queryParameters: ${options.queryParameters}");
      options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
    }
    if (options.data != null) {}

    if (options.headers.containsKey('requirestoken')) {
      options.headers.remove('requirestoken');

      // String? token = _sesProv.accessToken!.value;
      // String? refreshtoken = _sesProv.refreshToken!.value;
      // String token = await Session.getStringVal('accessToken');

      // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      // int expToken = decodedToken['exp'];
      // print(decodedToken);

      options.headers.addAll({
        // "Authorization": token,
        "Access-Control-Allow-Origin":
            "*", // Required for CORS support to work,
        "charset": "UTF-8",
        // "charset": "utf-8",
        "Content-Type": "application/json",
        // "application/x-www-form-urlencoded", //,application/json",
        "Access-Control-Allow-Credentials":
            true, // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      });
    }
    // print('REQUEST[${options.method}] => PATH: ${options.path}');
    handler.next(options);
    // return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print('RESPONSE[${response.statusCode}] => PATH: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path} RESPONSE => ${err.response}');
    try {
      if (err.response != null) {
        int responseCode = err.response!.statusCode!;
        // String token = _sesProv.accessToken!.value;
        // String oldAccessToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken);
        if (responseCode == 401) {
          // if (_sesProv.userId == null && _sesProv.userNnm == null) {
          return handler.next(err);
          // } else {
          //   //(token != null && responseCode == 401) {
          //   //&& _sharedPreferencesManager != null
          //   _dio.interceptors.requestLock.lock();
          //   _dio.interceptors.responseLock.lock();
          //   _dio.interceptors.errorLock.lock();
          //   // print('kesini');

          //   // String refreshToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyRefreshToken);
          //   // RefreshTokenBody refreshTokenBody = RefreshTokenBody('refresh_token', refreshToken);
          //   // ApiAuthRepository apiAuthRepository = ApiAuthRepository();
          //   // Token token = await apiAuthRepository.postRefreshAuth(refreshTokenBody);

          //   ApiRepository _apiRepo = ApiRepository();
          //   Map<String, dynamic> _dataForRequest = <String, dynamic>{};
          //   // _dataForRequest["grant_type"] = "password";
          //   // _dataForRequest["username"] = _sesProv.empNo;
          //   // _dataForRequest["password"] = _sesProv.passw;
          //   // _dataForRequest["client_secret"] = "testpass";
          //   // _dataForRequest["client_id"] = "testclient";
          //   // Token _token = await _apiRepo.getTokenRepo(_dataForRequest);
          //   // String newAccessToken = _token.access_token;
          //   // _sesProv.accessTokenvoid(newAccessToken);
          //   // Session.addToString(newAccessToken, 'accessToken');
          //   // await _sharedPreferencesManager.putString(SharedPreferencesManager.keyAccessToken, newAccessToken);
          //   // await _sharedPreferencesManager.putString(SharedPreferencesManager.keyRefreshToken, newRefreshToken);
          //   _dio.interceptors.requestLock.unlock();
          //   _dio.interceptors.responseLock.unlock();
          //   _dio.interceptors.errorLock.unlock();

          //   // _dio.interceptors.requestLock.lock();
          //   // _dio.interceptors.responseLock.lock();
          //   // _dio.interceptors.errorLock.lock();
          //   RequestOptions options = err.response!.requestOptions;
          //   // RequestOptions newOptions;
          //   // final optionss = new Options(
          //   //   method: options.method,
          //   //   headers: options.headers,
          //   // );
          //   // print(options.headers);
          //   // print(options.data);
          //   // options.headers.addAll({'requirestoken': true});
          //   // newOptions.headers.addAll({
          //   //   "Authorization": "Bearer $newAccessToken",
          //   //   "Access-Control-Allow-Origin":
          //   //       "*", // Required for CORS support to work,
          //   //   "Content-Type": "application/x-www-form-urlencoded",
          //   //   "Access-Control-Allow-Credentials":
          //   //       true, // Required for cookies, authorization headers with HTTPS
          //   //   "Access-Control-Allow-Headers":
          //   //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
          //   //   "Access-Control-Allow-Methods": "POST, OPTIONS"
          //   // });
          //   // newOptions.path = options.path;
          //   // newOptions.data = options.data;
          //   // newOptions.method = options.method;
          //   // newOptions.sendTimeout = options.sendTimeout;
          //   // newOptions.receiveTimeout = options.receiveTimeout;

          //   // options.headers
          //   //     .update("Authorization", (value) => "Bearer $newAccessToken");
          //   // _dio.request(options.path,
          //   //     queryParameters: options.data,
          //   //     options: new Options(
          //   //       method: options.method,
          //   //       headers: options.headers,
          //   //       receiveTimeout: options.receiveTimeout,
          //   //       sendTimeout: options.sendTimeout,
          //   //     ));
          //   _dio.fetch(options).then((value) => handler.resolve(value)).onError(
          //       (error, stackTrace) => handler.reject(error as DioError));
          //   //     .then((value) {
          //   // });
          // }
        } else {
          return handler.next(err);
        }
      } else {
        return handler.next(err);
      }
    } catch (e) {
      return handler.next(err);
    }
  }
  // return super.onError(err, handler);
}
