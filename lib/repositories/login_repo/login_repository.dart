import 'package:smart_farm_application/base/provider/dio_client.dart';

import '../../model/information.dart';

abstract class LoginRepository {
  Future<Information> getInformation(String email, String password);

  LoginRepository(DioClient dioClient);
}
