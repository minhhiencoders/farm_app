import 'package:dio/dio.dart';
import 'package:smart_farm_application/base/provider/api_provider.dart';
import 'package:smart_farm_application/model/client_infor.dart';
import 'package:smart_farm_application/repositories/client_repo/client_infor_repo.dart';
import 'package:smart_farm_application/configs/api_endpoint.dart';

import '../../base/custom-exception.dart';

class ClientInfoImplement extends ClientInfoRepository {
  ClientInfoImplement(this._apiProvider) : super(_apiProvider);
  final ApiProvider _apiProvider;

  @override
  Future<ClientInfor> getClientInfo(String token, int id) async {
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _apiProvider.getHasOption(
          '$DOMAIN_URL/mapi/client/1/basics', Options(headers: header));
      if (response['HttpStatusCode'] != 200) {
        throw ECException(response['message']);
      }
      return ClientInfor.fromJson(response);
    } on ECException catch (e) {
      throw ECException(e.toString());
    }
  }
}
