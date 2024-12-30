import 'package:smart_farm_application/base/provider/api_provider.dart';
import 'package:smart_farm_application/model/client_infor.dart';

abstract class ClientInforRepository {
  Future<ClientInfor> getClientInfo(String token, int id);

  ClientInforRepository(ApiProvider apiProvider);
}
