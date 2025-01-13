import 'dart:typed_data';

import 'package:smart_farm_application/base/provider/dio_client.dart';

abstract class ReportRepository {
  Future<dynamic> getImagesReport(String token, String sectorId);
  Future<dynamic> getCompareReport(String token, String clientId, String fromDate, String toDate);
  ReportRepository(DioClient dioClient);
}
