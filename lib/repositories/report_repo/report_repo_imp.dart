import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:smart_farm_application/repositories/report_repo/report_repo.dart';

import '../../base/custom-exception.dart';
import '../../base/provider/api_provider.dart';
import '../../configs/api_endpoint.dart';

class ReportImplement extends ReportRepository {
  ReportImplement(this._apiProvider) : super(_apiProvider);
  final ApiProvider _apiProvider;

  @override
  Future<dynamic> getImagesReport(String token, String sectorId) async {
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _apiProvider.getHasOption(
          '$DOMAIN_URL/img/sector/$sectorId/flow_acc_mm_daily_weekly/column',
          Options(headers: header, responseType: ResponseType.bytes));
      return response;
    } on ECException catch (e) {
      throw ECException(e.toString());
    }
  }

  @override
  Future<dynamic> getCompareReport(String token, String clientId, String fromDate, String toDate) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _apiProvider.getHasOption(
          '$DOMAIN_URL/api/client/$clientId/compare/$fromDate/$toDate',
          Options(headers: header));
      return jsonDecode(response['data']);
    } on ECException catch (e) {
      throw ECException(e.toString());
    }
  }
}
