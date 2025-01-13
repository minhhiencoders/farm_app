import 'package:smart_farm_application/base/provider/dio_client.dart';

abstract class ControlRepository{
  Future<dynamic> turnOnSector(String token, int sectorId, String time);
  Future<dynamic> turnOffSector(String token, int sectorId);

  Future<dynamic> turnOnSectorHasFertilizer(String token, int sectorId, String time,String k, String n, String p, String mix, String a1, String b1, String a2, String b2, String a3, String b3);

  Future<dynamic> setDailyTimer(String token, int sectorId, int clientId, String timeBefore, String countTimer);
  Future<dynamic> setTimer(String token, int sectorId, String timeBefore, String countTimer);
  Future<dynamic> setAutoIrrigation(String token, int sectorId, String duration, String maxPerDay, String maxTemp, String minRH);

  ControlRepository(DioClient dioClient);
}