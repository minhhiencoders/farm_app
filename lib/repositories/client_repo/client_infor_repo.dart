import 'package:smart_farm_application/model/client_infor.dart';

import '../../base/provider/dio_client.dart';

abstract class ClientInfoRepository {
  Future<ClientInfor> getClientInfo(String token, int id);

  ClientInfoRepository(DioClient dioClient);
}
