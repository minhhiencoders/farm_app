import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/model/client_infor.dart';
import 'package:smart_farm_application/repositories/client_repo/client_infor_imp.dart';

import '../base/provider/api_provider_imp.dart';

class ClientInfoNotifier extends StateNotifier<AsyncValue<ClientInfor>> {
  final ClientInfoImplement clientInfoImplement;

  ClientInfoNotifier(this.clientInfoImplement)
      : super(const AsyncValue.loading());

  Future<void> getClientInfo(String token, int id) async {
    try {
      state = const AsyncValue.loading();
      await clientInfoImplement.getClientInfo(token, id).then((client) {
        state = AsyncValue.data(client);
      },);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final clientInfoServiceProvider = Provider<ClientInfoImplement>(
    (ref) => ClientInfoImplement(ApiProviderImp()));

final clientInfoProvider =
    StateNotifierProvider<ClientInfoNotifier, AsyncValue<ClientInfor>>((ref) {
  return ClientInfoNotifier(ref.read(clientInfoServiceProvider));
});
