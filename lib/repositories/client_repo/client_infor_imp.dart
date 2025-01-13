import 'package:dio/dio.dart';
import 'package:smart_farm_application/model/client_infor.dart';
import 'package:smart_farm_application/repositories/client_repo/client_infor_repo.dart';
import 'package:smart_farm_application/configs/api_endpoint.dart';

import '../../base/custom-exception.dart';
import '../../base/provider/dio_client.dart';

class ClientInfoImplement extends ClientInfoRepository {
  ClientInfoImplement(this._dioClient) : super(_dioClient);
  final DioClient _dioClient;

  @override
  Future<ClientInfor> getClientInfo(String token, int id) async {
    try {
      final header = {HEADER_AUTH_KEY: token};
      final response = await _dioClient.get('$DOMAIN_URL/mapi/client/1/basics',
          options: Options(headers: header));
      return ClientInfor.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
