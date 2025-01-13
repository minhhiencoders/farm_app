import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:smart_farm_application/repositories/report_repo/report_repo.dart';

import '../../base/custom-exception.dart';
import '../../base/provider/dio_client.dart';
import '../../configs/api_endpoint.dart';

class ReportImplement extends ReportRepository {
  ReportImplement(this._dioClient) : super(_dioClient);
  final DioClient _dioClient;

  @override
  Future<dynamic> getImagesReport(String token, String sectorId) async {
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _dioClient.get(
          '$DOMAIN_URL/img/sector/$sectorId/flow_acc_mm_daily_weekly/column',
          options: Options(headers: header, responseType: ResponseType.bytes));
      return response.data;
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getCompareReport(String token, String clientId, String fromDate, String toDate) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _dioClient.get(
          '$DOMAIN_URL/api/client/$clientId/compare/$fromDate/$toDate',
          options: Options(headers: header));
      return jsonDecode(response.data);
    } on ECException catch (e) {
      throw ECException(e.toString());
    }
  }
}
