import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/base/custom-exception.dart';
import 'package:smart_farm_application/repositories/control_repo/control_repo_imp.dart';

import '../base/provider/dio_client.dart';
import '../base/provider/dio_exceptions.dart';
import '../model/daily_timer.dart';

class ControlNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final ControlImplement controlImplement;

  ControlNotifier(this.controlImplement)
      : super(const AsyncValue.loading());

  Future<List<DailyTimer>> setDailyTimer(String token, int sectorId, int clientId, String timeBefore, String countTimer) async {
    try {
      final response = await controlImplement.setDailyTimer(token, sectorId, clientId, timeBefore, countTimer);
      if (response is List) {
        return List<DailyTimer>.from(
            response.map((item) => DailyTimer.fromList(item))
        );
      }
      throw ECException('Unexpected response format');
    } on DioException catch (e) {
      throw ECException(DioExceptions.fromDioError(e).message);
    }
  }

  Future<dynamic> setTimer(String token, int sectorId, String timer, String countTimer) async {
    try {
      return await controlImplement.setTimer(token, sectorId, timer, countTimer);
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  Future<dynamic> setAutoIrrigation(String token, int sectorId, String duration, String maxPerDay, String maxTemp, String minRH) async {
    try {

      return await controlImplement.setAutoIrrigation(token, sectorId, duration,maxPerDay, maxTemp, minRH);
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  Future<dynamic> startSector(String token, int id, String time) async {
    try {
      return await controlImplement.turnOnSector(token, id, time);
    } on DioException catch (e) {
      throw ECException(DioExceptions.fromDioError(e).message);
    }
  }

  Future<dynamic> stopSector(String token, int id) async {
    try {
      return await controlImplement.turnOffSector(token, id);
    }on DioException catch (e) {
      throw ECException(DioExceptions.fromDioError(e).message);
    }
  }


  Future<dynamic> startSectorHasFertilizer(String token, int sectorId, String time, String k, String n, String p, String mix, String a1, String b1, String a2, String b2, String a3, String b3) async {
    try {
      return await controlImplement.turnOnSectorHasFertilizer(token, sectorId, time, k, n, p, mix,a1, b1, a2, b2, a3, b3);
    } on DioException catch (e) {
      throw ECException(DioExceptions.fromDioError(e).message);
    }
  }
}


final controlServiceProvider = Provider<ControlImplement>(
        (ref) => ControlImplement(DioClient(Dio()))
);

final controlProvider = StateNotifierProvider<ControlNotifier, AsyncValue<dynamic>>(
        (ref) => ControlNotifier(ref.read(controlServiceProvider))
);