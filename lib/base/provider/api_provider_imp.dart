import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../custom-exception.dart';
import 'api_provider.dart';

class ApiProviderImp extends ApiProvider {
  final Dio _dio;

  ApiProviderImp()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    _dio.interceptors
        .add(PrettyDioLogger(responseBody: true, requestHeader: false, error: true, request: false));
  }

  @override
  Future<dynamic> get(String url) async {
    try {
      return await _dio.get(url).then((value) => _processResponse(value));
    } on SocketException {
      throw ECException("No internet connection");
    } on TimeoutException {
      throw ECException("Request timeout");
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  @override
  Future<dynamic> getHasOption(String url, Options option) async {
    try {
      return await _dio
          .get(url, options: option)
          .then((value) => option.responseType == ResponseType.bytes ? value.data : _processResponse(value))
          .onError(
        (error, stackTrace) {
          if (error is DioException && error.response != null) {
            throw ECException('${error.response?.data['exc']}');
          }
        },
      );
    } on SocketException {
      throw ECException("No internet connection");
    } on TimeoutException {
      throw ECException("Request timeout");
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  @override
  Future<dynamic> post(String url, dynamic body) async {
    try {
      return await _dio
          .post(url, data: body)
          .then((value) => _processResponse(value))
          .onError((error, stackTrace) {
        if (error is DioException && error.response != null) {
          throw ECException('${error.response?.data['exc']}');
        }
      });
    } on SocketException {
      throw ECException("No internet connection");
    } on TimeoutException {
      throw ECException("Request timeout");
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  @override
  Future<dynamic> postMultipart(String url, file, field) async {
    try {
      final formData = FormData.fromMap({
        ...field,
        'file': MultipartFile.fromFileSync(file.path),
      });
      return await _dio
          .post(url, data: formData)
          .then((value) => _processResponse(value));
    } on SocketException {
      throw ECException("No internet connection");
    } on TimeoutException {
      throw ECException("Request timeout");
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  dynamic _processResponse(Response response) {
    var responseJson = response.data;
    final statusCode = response.statusCode ?? 500;

    // Map for status codes
    const statusCodeMap = {
      200: 200,
      400: 400,
      401: 401,
      403: 403,
      418: 418,
      500: 500,
    };
    if(responseJson is! Map){
      responseJson = {'data': response.data};
    }
    responseJson['HttpStatusCode'] = statusCodeMap[statusCode] ?? 500;

    if (statusCode >= 200 && statusCode < 300) {
      return responseJson;
    } else if (statusCode == 418) {
      throw ECException("Error: HTTP ${responseJson['exc']}");
    } else {
      throw ECException("Error: HTTP $statusCode");
    }
  }
}
