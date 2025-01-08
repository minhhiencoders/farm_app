import 'package:smart_farm_application/base/provider/api_provider.dart';

abstract class ControlRepository{
  Future<dynamic> turnOnSector(String token, int sectorId, String time);
  Future<dynamic> turnOffSector(String token, int sectorId);

  Future<dynamic> setDailyTimer(String token, int sectorId, int clientId, String timeBefore, String countTimer);

  ControlRepository(ApiProvider apiProvider);
}