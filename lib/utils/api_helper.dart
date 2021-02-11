import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'network_configuration.dart';
import 'server_exception.dart';

class APIHelper {
  final Dio dio;

  APIHelper({@required this.dio}) {
    _initApiClient();
  }

  //for api helper testing only
  APIHelper.test({@required this.dio});

  void _initApiClient() {
    dio
      // ..options.headers.addAll({'parameter': 'parameter'})
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) => requestInterceptor(options),
          onResponse: (Response response) => responseInterceptor(response),
          onError: (DioError dioError) => errorInterceptor(dioError),
        ),
      )
      ..options.baseUrl = NetworkConfiguration.networkUrl;
  }

  Future<dynamic> get(String path, {Map<String, dynamic> queryParameters}) async {
    // bypass CERTIFICATE_VERIFY_FAILED
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioError catch (e) {
      throw ServerException(e, e.message);
    } catch (e) {
      throw ServerException(e, "Unknown error");
    }
  }

  dynamic requestInterceptor(RequestOptions options) async {
    print(
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    print("Headers:");
    options.headers?.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null && options.queryParameters.isNotEmpty) {
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print("--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    return options;
  }

  dynamic responseInterceptor(Response response) {
    print(
        "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    print("Headers:");
    response.headers?.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
  }

  dynamic errorInterceptor(DioError dioError) {
    print(
        "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    print("${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    print("<-- End error");
  }
}
