
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio getDio(BuildContext context) {
  Dio dio = new Dio();
  dio.options.baseUrl = 'https://parallelum.com.br/fipe/api/v1/';
  dio.interceptors.add(new APIInterceptor(context));
  dio.options.connectTimeout = 60000;
  dio.options.receiveTimeout = 60000;
  return dio;
}

class APIInterceptor extends Interceptor {
  final BuildContext context;
  APIInterceptor(this.context);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['content-Type'] = 'application/json';
    options.headers["Accept"] = "application/json";
    print(options.uri);
    super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}