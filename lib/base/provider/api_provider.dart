import 'package:dio/dio.dart';

abstract class ApiProvider {
  Future<dynamic> get(String url);
  Future<dynamic> getHasOption(String url, Options header);
  Future<dynamic> post(String url, dynamic body);
  Future<dynamic> postMultipart(String url, dynamic file, dynamic field);
}
