import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/base/provider/dio_client.dart';
import 'package:smart_farm_application/model/client_infor.dart';
import 'package:smart_farm_application/repositories/client_repo/client_infor_imp.dart';

import '../base/provider/dio_exceptions.dart';

class ClientInfoNotifier extends StateNotifier<AsyncValue<ClientInfor>> {
  final ClientInfoImplement clientInfoImplement;

  ClientInfoNotifier(this.clientInfoImplement)
      : super(const AsyncValue.loading());

  Future<void> getClientInfo(String token, int id) async {
    try {
      state = const AsyncValue.loading();
      await clientInfoImplement.getClientInfo(token, id).then(
        (client) {
          state = AsyncValue.data(client);
        },
      );
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    }
  }
}

final clientInfoServiceProvider = Provider<ClientInfoImplement>(
    (ref) => ClientInfoImplement(DioClient(Dio())));

final clientInfoProvider =
    StateNotifierProvider<ClientInfoNotifier, AsyncValue<ClientInfor>>((ref) {
  return ClientInfoNotifier(ref.read(clientInfoServiceProvider));
});
