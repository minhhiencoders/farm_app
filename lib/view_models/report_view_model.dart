import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/provider/api_provider_imp.dart';
import '../repositories/report_repo/report_repo_imp.dart';

class ReportNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final ReportImplement reportImplement;

  ReportNotifier(this.reportImplement) : super(const AsyncValue.loading());

  Future<void> getImagesReport(String token, String sectorId) async {
    try {
      state = const AsyncValue.loading();
      final img = await reportImplement.getImagesReport(token, sectorId);
      state = AsyncValue.data(img);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getCompareReport(String token, String clientId, String fromDate, String toDate) async {
    try {
      state = const AsyncValue.loading();
      final responseReport = await reportImplement.getCompareReport(token, clientId, fromDate, toDate);
      state = AsyncValue.data(responseReport);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final reportServiceProvider =
    Provider<ReportImplement>((ref) => ReportImplement(ApiProviderImp()));

final reportProvider =
StateNotifierProvider<ReportNotifier, AsyncValue<dynamic>>((ref) {
  return ReportNotifier(ref.read(reportServiceProvider));
});
