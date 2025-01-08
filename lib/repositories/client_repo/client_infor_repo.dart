import 'package:smart_farm_application/base/provider/api_provider.dart';
import 'package:smart_farm_application/model/client_infor.dart';

abstract class ClientInfoRepository {
  Future<ClientInfor> getClientInfo(String token, int id);

  ClientInfoRepository(ApiProvider apiProvider);
}
