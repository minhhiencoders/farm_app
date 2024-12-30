import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/model/client_infor.dart';
import 'package:smart_farm_application/repositories/client_repo/client_infor_imp.dart';

import '../base/provider/api_provider_imp.dart';

class ClientInforNotifier extends StateNotifier<AsyncValue<ClientInfor>> {
  final ClientInforImplement clientInforImplement;

  ClientInforNotifier(this.clientInforImplement)
      : super(const AsyncValue.loading());

  Future<void> getClientInfor(String token, int id) async {
    try {
      state = const AsyncValue.loading();
      await clientInforImplement.getClientInfo(token, id).then((client) {
        state = AsyncValue.data(client);
      },);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Provider cho WeatherService
final clientInforServiceProvider = Provider<ClientInforImplement>(
    (ref) => ClientInforImplement(ApiProviderImp()));

// Provider cho WeatherNotifier
final clientInforProvider =
    StateNotifierProvider<ClientInforNotifier, AsyncValue<ClientInfor>>((ref) {
  return ClientInforNotifier(ref.read(clientInforServiceProvider));
});
