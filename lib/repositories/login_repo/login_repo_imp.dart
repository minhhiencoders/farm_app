import 'package:smart_farm_application/base/provider/dio_client.dart';
import 'package:smart_farm_application/configs/api_endpoint.dart';
import 'package:smart_farm_application/model/information.dart';
import 'package:smart_farm_application/repositories/login_repo/login_repository.dart';

class LoginRepoImp extends LoginRepository {
  final DioClient _dioClient;

  LoginRepoImp(this._dioClient) : super(_dioClient);
  @override
  Future<Information> getInformation(String email, String password) async {
    try {
      final payload = {"email": email, "password": password};
      final response = await _dioClient.post(LOGIN_URL, data: payload);
      return Information.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
