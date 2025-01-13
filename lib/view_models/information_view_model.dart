import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/model/information.dart';

import '../base/provider/dio_client.dart';
import '../base/provider/dio_exceptions.dart';
import '../repositories/login_repo/login_repo_imp.dart';

class InformationNotifier extends StateNotifier<AsyncValue<Information>> {
  final LoginRepoImp loginRepoImp;

  InformationNotifier(this.loginRepoImp) : super(const AsyncValue.loading());

  Future<void> authenticationLogin(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final information = await loginRepoImp.getInformation(email, password);
      state = AsyncValue.data(information);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      state = AsyncValue.error(errorMessage, StackTrace.current);
    }
  }
}

// Provider cho WeatherService
final informationServiceProvider =
    Provider<LoginRepoImp>((ref) => LoginRepoImp(DioClient(Dio())));

// Provider cho WeatherNotifier
final informationProvider =
    StateNotifierProvider<InformationNotifier, AsyncValue<Information>>((ref) {
  final informationService = ref.read(informationServiceProvider);
  return InformationNotifier(informationService);
});
