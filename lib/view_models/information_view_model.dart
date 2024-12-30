import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/base/provider/api_provider_imp.dart';
import 'package:smart_farm_application/model/information.dart';

import '../repositories/login_repo/login_repo_imp.dart';

class InformationNotifier extends StateNotifier<AsyncValue<Information>> {
  final LoginRepoImp loginRepoImp;

  InformationNotifier(this.loginRepoImp) : super(const AsyncValue.loading());

  Future<void> authenticationLogin(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final information = await loginRepoImp.getInformation(email, password);
      state = AsyncValue.data(information);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Provider cho WeatherService
final informationServiceProvider =
    Provider<LoginRepoImp>((ref) => LoginRepoImp(ApiProviderImp()));

// Provider cho WeatherNotifier
final informationProvider =
    StateNotifierProvider<InformationNotifier, AsyncValue<Information>>((ref) {
  final informationService = ref.read(informationServiceProvider);
  return InformationNotifier(informationService);
});
