import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/base/custom-exception.dart';
import 'package:smart_farm_application/repositories/control_repo/control_repo_imp.dart';

import '../base/provider/api_provider_imp.dart';
import '../model/daily_timer.dart';

class ControlNotifier extends StateNotifier<dynamic> {
  final ControlImplement controlImplement;

  ControlNotifier(this.controlImplement)
      : super(const AsyncValue.loading());

  Future<dynamic> startSector(String token, int id, String time) async {
    try {
      return await controlImplement.turnOnSector(token, id, time);
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  Future<dynamic> stopSector(String token, int id) async {
    try {
      return await controlImplement.turnOffSector(token, id);
    } catch (e) {
      throw ECException(e.toString());
    }
  }

  Future<dynamic> setDailyTimer(String token, int sectorId, int clientId, String timeBefore, String countTimer) async {
    try {
      final response = await controlImplement.setDailyTimer(token, sectorId, clientId, timeBefore, countTimer);
      return response.map((item) => DailyTimer.fromList(item)).toList();
    } catch (e) {
      throw ECException(e.toString());
    }
  }
}

final controlServiceProvider = Provider<ControlImplement>(
        (ref) => ControlImplement(ApiProviderImp()));

final controlProvider =
StateNotifierProvider<ControlNotifier, dynamic>((ref) {
  return ControlNotifier(ref.read(controlServiceProvider));
});
