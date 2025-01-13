import 'package:dio/dio.dart';
import 'package:smart_farm_application/base/provider/dio_client.dart';
import 'package:smart_farm_application/repositories/control_repo/control_repo.dart';

import '../../base/custom-exception.dart';
import '../../configs/api_endpoint.dart';

class ControlImplement extends ControlRepository{
  ControlImplement(this._dioClient) : super(_dioClient);
  final DioClient _dioClient;

  @override
  Future turnOnSector(String token, int sectorId, String time) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _dioClient.get(
          '$DOMAIN_URL/api/sector/$sectorId/run/$time',
          options: Options(headers: header));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future turnOffSector(String token, int sectorId) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _dioClient.get(
          '$DOMAIN_URL/api/sector/$sectorId/stop',
          options: Options(headers: header));
      return response.data;
    } on ECException catch (e) {
      rethrow;
    }
  }

  @override
  Future setDailyTimer(String token, int sectorId, int clientId, String timeBefore, String countTimer) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _dioClient.get(
          '$DOMAIN_URL/api/sector/$sectorId/controls/daily/timer/1/$timeBefore/$countTimer',
          options: Options(headers: header));
      return response.data;
    } catch (e) {
      rethrow;
    }

  }

  @override
  Future setTimer(String token, int sectorId, String timeBefore, String countTimer) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _dioClient.get(
          '$DOMAIN_URL/api/sector/$sectorId/controls/calendar/new/$timeBefore/$countTimer',
          options: Options(headers: header));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future setAutoIrrigation(String token, int sectorId, String duration, String maxPerDay, String maxTemp, String minRH) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final payload = {"maxTemp":maxTemp,"minRH": minRH,"duration":duration,"maxPerDay":maxPerDay};
      final response = await _dioClient.post(
          '$DOMAIN_URL/api/sector/$sectorId/controls/setpoint/save',
          options: Options(headers: header), data: payload);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future turnOnSectorHasFertilizer(String token, int sectorId, String time, String k, String n, String p, String mix, String a1, String b1, String a2, String b2, String a3, String b3) async{
    try {
      final header = {HEADER_AUTH_KEY: token};
      final payload = {"mix":mix,"N":n,"P":p,"K":k,"A1": a1,"B1":b1,"A2":a2,"B2":b2,"A3":a3,"B3":b3};
      final response = await _dioClient.post(
          '$DOMAIN_URL/api/sector/$sectorId/runFert/$time',
          options: Options(headers: header), data: payload);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}