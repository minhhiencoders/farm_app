import 'package:dio/dio.dart';
import 'package:smart_farm_application/repositories/control_repo/control_repo.dart';

import '../../base/custom-exception.dart';
import '../../base/provider/api_provider.dart';
import '../../configs/api_endpoint.dart';

class ControlImplement extends ControlRepository{
  final ApiProvider _apiProvider;

  ControlImplement(this._apiProvider) : super(_apiProvider);

  @override
  Future turnOnSector(String token, int sectorId, String time) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _apiProvider.getHasOption(
          '$DOMAIN_URL/api/sector/$sectorId/run/$time',
          Options(headers: header));
      return response;
    } on ECException catch (e) {
      throw ECException(e.toString());
    }
  }

  @override
  Future turnOffSector(String token, int sectorId) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _apiProvider.getHasOption(
          '$DOMAIN_URL/api/sector/$sectorId/stop',
          Options(headers: header));
      return response;
    } on ECException catch (e) {
      throw ECException(e.toString());
    }
  }

  @override
  Future setDailyTimer(String token, int sectorId, int clientId, String timeBefore, String countTimer) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _apiProvider.getHasOption(
          '$DOMAIN_URL/api/sector/$sectorId/controls/daily/timer/1/$timeBefore/$countTimer',
          Options(headers: header));
      return response['data'];
    } on ECException catch (e) {
      throw ECException(e.toString());
    }

  }

}